//
//  INetworkConfiguration.swift
//  BankExchange
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.


import Foundation

protocol INetworkConfiguration {
    func getHeaders() -> [String: String]
    func getBaseUrl() -> String
}
