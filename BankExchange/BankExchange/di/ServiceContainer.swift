//
//  ServiceContainer.swift
//  Sensor-Agent
//
//  Created by azharkova on 15.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol IServiceContainer {
    var currencyManager: ICurrencyManager {get }
}

class ServiceContainer: IServiceContainer {
    private var _currencyManager: ICurrencyManager?
    
    var currencyManager: ICurrencyManager {
       get   {
            if (_currencyManager == nil){
                _currencyManager = CurrencyManager()
            }
            return _currencyManager!
        }
    }
}
