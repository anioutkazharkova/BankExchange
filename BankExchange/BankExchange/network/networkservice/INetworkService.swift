//
//  INetworkService.swift
//  Sensor-Agent
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.

import Foundation

protocol INetworkService: class {
    func request<T:Codable>(url: String,
    parameters: [String: Any],
    method: Methods,
    completion: @escaping (ContentResponse<T>) -> Void)
    var backgroundCompletionHandler: (() -> Void)? {get set}
    func restartManager(background: Bool)
    func cancelAllRequests() 
}
