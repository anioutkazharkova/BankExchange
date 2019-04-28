//
//  ExchangeItem.swift
//  BankExchange
//
//  Created by 1 on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

class ExchangeItem: NSObject {
    var currency: Currency = .EUR
    var amount: Double = 100.0
    
    
    init(currency: Currency, amount: Double){
        self.currency = currency
        self.amount = amount
    }
    
    func changeAmount(amount: Double){
        self.amount += amount
    }
}
