//
//  ICurrencyManager.swift
//  BankExchange
//
//  Created by 1 on 28.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol ICurrencyManager : class {
    var delegate: CurrencyManagerDelegate? {get set}
    
    var currentRateData: BaseRate? {get}
    
    func start()
    
    func stop()
    
   // func rateFromBase(currency: Currency)->Double
    
   // func rate(from currency: Currency, to: Currency)->Double
}


protocol CurrencyManagerDelegate : class {
    func rateChanged()
}
