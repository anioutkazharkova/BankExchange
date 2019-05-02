//
//  ContentResponse.swift
//  BankExchange
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.

import UIKit
import ObjectMapper

// MARK: Error types
enum ErrorType: String, Codable {
    case network, other
}

// MARK: generic type for network response
class ContentResponse<T: Mappable&Codable> {
    var content: T?
    var error: ErrorResponse?
    var code: Int = 0

    init() {}

    convenience init(response: HTTPURLResponse, json: Any) {
        self.init()
        code = response.statusCode
        guard let result = Mapper<T>().map(JSONObject: json) else {
            error = Mapper<ErrorResponse>().map(JSONObject: json)
            return
        }
        content = result
    }

    convenience init(response: HTTPURLResponse, data: Data) {
        self.init()
        let jsonDecoder = JSONDecoder()
        code = response.statusCode
        do {
            let result = try jsonDecoder.decode(T.self, from: data)
            content = result
            error = try jsonDecoder.decode(ErrorResponse.self, from: data)

        } catch {}
    }

    convenience init(error: ErrorResponse) {
        self.init()
        self.error = error
    }
}
