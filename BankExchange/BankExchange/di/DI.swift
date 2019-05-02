//
//  DI.swift
//  BankExchange
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.

import UIKit

public class DI {
    private static let shared = DI()

    static var container: IDIContainer {
        return shared.container
    }

    static var serviceContainer: IServiceContainer {
        return shared.serviceContainer
    }

    private let container: IDIContainer
    private let serviceContainer: IServiceContainer

    init() {
        container = DIContainer()
        serviceContainer = ServiceContainer()

    }
}
