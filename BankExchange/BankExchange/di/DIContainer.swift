//
//  DIContainer.swift
//  Sensor-Agent
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit

protocol IDIContainer {
    var networkService: INetworkService { get }
    var networkConfig: INetworkConfiguration { get }
}

class DIContainer: IDIContainer {
    private var _networkService: INetworkService?
    private var _networkConfig: INetworkConfiguration?

    var networkService: INetworkService {
        if (_networkService == nil) {
            _networkService = NetworkService(networkConfiguration: DI.container.networkConfig)
        }
        return _networkService!
    }
    var networkConfig: INetworkConfiguration {
        if (_networkConfig == nil ) {
             _networkConfig = NetworkConfiguration()
        }
        return _networkConfig!
    }
}
