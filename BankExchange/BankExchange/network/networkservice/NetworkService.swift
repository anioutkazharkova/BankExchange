//
//  NetworkService.swift
//  BankExchange
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.

import UIKit
import Alamofire
import ObjectMapper

// MARK: Method wrapper to prevent including Alamofire in presenters
enum Methods {
    case get, post, patch, delete
    
    func toMehtod() -> HTTPMethod {
        switch (self) {
        case .get:
            return .get
        case .post:
            return .post
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
}

// MARK: Network service
class NetworkService: INetworkService {
    
    private var currentManager: SessionManager?
    private var requestSessionManager: SessionManager
    private var networkConfiguration: INetworkConfiguration
    
    private lazy var backgroundManager: Alamofire.SessionManager = {
        let bundleIdentifier = "sensor"
        return Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: bundleIdentifier + ".background"))
    }()
    
    var backgroundCompletionHandler: (() -> Void)? {
        get {
            return backgroundManager.backgroundCompletionHandler
        }
        set {
            backgroundManager.backgroundCompletionHandler = newValue
        }
    }
    
    init(networkConfiguration: INetworkConfiguration) {
        self.networkConfiguration = networkConfiguration
        requestSessionManager = SessionManager.default
        self.currentManager = requestSessionManager
    }
    
    func restartManager(background: Bool = false) {
        self.currentManager = background ? backgroundManager : requestSessionManager
    }
    
    // MARK: Generic request method
    public func request<T:Codable>(url: String,
                                   parameters: [String: Any] = [:],
                                   method: Methods,
                                   completion: @escaping (ContentResponse<T>) -> Void) {
        
        let urlEncoding = JSONEncoding.default
        let requestURL = "\(self.networkConfiguration.getBaseUrl())\(url)"
        let queue = DispatchQueue(label: "queue\(Date().timeIntervalSince1970)",
            qos: .background,
            attributes:.concurrent)
        self.currentManager?.request(requestURL, method: method.toMehtod(), parameters: parameters, encoding: urlEncoding, headers: self.networkConfiguration.getHeaders())
            .responseJSON(queue: queue) { response in
              
                    if let _ = response.error {
                        let errorResult = ContentResponse<T>(error: ErrorResponse(type: .network))
                        completion(errorResult)
                        return
                    }
                    
                    guard let urlResponse = response.response, let json = response.value else {
                        let errorResult = ContentResponse<T>(error: ErrorResponse(type: .network))
                        completion(errorResult)
                        return
                    }
                
                let result = ContentResponse<T>(response: urlResponse, json: json)
                DispatchQueue.main.async {
                    
                    completion(result)
                }
        }
    }
    
    func cancelAllRequests() {
        currentManager?.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
         sessionDataTask.forEach { $0.cancel() }
         uploadData.forEach { $0.cancel() }
         downloadData.forEach { $0.cancel() }
         }
    }
}
