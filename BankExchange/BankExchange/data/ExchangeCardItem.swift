//
//  ExchangeCardItem.swift
//  BankExchange
//
//  Created by 1 on 02.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

class ExchangeCardItem {
    var exchangeItem: ExchangeItem?
    var currentRate: Double = 1.0
    var sumValue:String = ""
    var pairCurrency: Currency = .EUR
    
    func rateInfo()->String {
        let symbol = (exchangeItem?.currency ?? .EUR).symbol
        return "\(symbol)1 = \(pairCurrency.symbol)\(String(format:"%.2f",currentRate))"
    }
    
    func amountInfo()->String {
        let symbol = (exchangeItem?.currency ?? .EUR).symbol
        return "You have: \(symbol) \(String(format:"%.2f",exchangeItem?.amount ?? 0.0))"
    }
}
