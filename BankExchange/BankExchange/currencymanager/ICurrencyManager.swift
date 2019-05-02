//
//  ICurrencyManager.swift
//  BankExchange
//
//  Created by azharkova on 28.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol ICurrencyManager : class {
    var delegate: CurrencyManagerDelegate? {get set}
    
    var currentRateData: BaseRate? {get}
    
    func start()
    
    func stop()
}


protocol CurrencyManagerDelegate : class {
    func rateChanged()
}
