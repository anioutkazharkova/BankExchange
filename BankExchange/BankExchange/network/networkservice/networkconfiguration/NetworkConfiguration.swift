//
//  NetworkConfiguration.swift
//  BankExchange
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.

import UIKit

// MARK: base network configuration
class NetworkConfiguration: INetworkConfiguration {

    private let apiUrl = "https://api.exchangeratesapi.io/"

    func getHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }

    func getBaseUrl() -> String {
        return apiUrl
    }

}
