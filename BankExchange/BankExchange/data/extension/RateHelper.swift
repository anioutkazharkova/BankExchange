//
//  RateHelper.swift
//  BankExchange
//
//  Created by 1 on 01.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

class RateHelper {
    private weak var currencyManager = DI.serviceContainer.currencyManager
    
    static   let shared = RateHelper()
    private init() {}
    
    func rateFromBase(currency: Currency) -> Double {
        if let rate = currencyManager?.currentRateData {
            if (currency == rate.base) {
                return 1
            } else {
                return rate.rates[currency] ?? 0.0
            }
        }
        return 0.0
    }
    
    func rate(from currency: Currency, to: Currency) -> Double {
        if currency == to {
            return 1.0 
        }
        let sourceRate = rateFromBase(currency: currency)
        let distanceRate = rateFromBase(currency: to)
        
        return sourceRate > 0 ?  distanceRate/sourceRate : 0.0
    }
}
