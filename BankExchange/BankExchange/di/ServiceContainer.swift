//
//  ServiceContainer.swift
//  BankExchange
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol IServiceContainer {
    var currencyManager: ICurrencyManager {get }
    var currencyService: ICurrencyService {get}
}

class ServiceContainer: IServiceContainer {
    private var _currencyManager: ICurrencyManager?
    private var _currencyService: ICurrencyService?

    var currencyManager: ICurrencyManager {
       get {
            if (_currencyManager == nil) {
                _currencyManager = CurrencyManager()
            }
            return _currencyManager!
        }
    }

    var currencyService: ICurrencyService {
        get {
            if (_currencyService == nil) {
                _currencyService = CurrencyService()
            }
            return _currencyService!
        }
    }
}
