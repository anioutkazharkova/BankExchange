//
//  IExchangeView.swift
//  BankExchange
//
//  Created by 1 on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol IExchangeView :class {
    func showChanged(fromItem: ExchangeItem, toItem: ExchangeItem)
    
    func updateSelected()
    
    func loadData(items:[ExchangeItem])
}
