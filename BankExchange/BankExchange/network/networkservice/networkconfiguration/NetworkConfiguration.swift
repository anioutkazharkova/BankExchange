//
//  NetworkConfiguration.swift
//  Sensor-Agent
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.

import UIKit

// MARK: base network configuration
class NetworkConfiguration: INetworkConfiguration {

    private let apiUrl = "https://api.exchangeratesapi.io/"
   // private let apiKey = "5b86b7593caa4f009fea285cc74129e2"

    func getHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }

    func getBaseUrl() -> String {
        return apiUrl
    }

}
