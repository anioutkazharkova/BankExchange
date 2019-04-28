//
//  ExchangePresenter.swift
//  BankExchange
//
//  Created by 1 on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

class ExchangePresenter: IExchangePresenter {
    weak var view: IExchangeView?
    
    private weak var currencyManager = DI.serviceContainer.currencyManager
    private var exchangeData:[ExchangeItem] = [ExchangeItem]()
    
    
    static func setup(view: IExchangeView?)->IExchangePresenter? {
        let presenter = ExchangePresenter()
        presenter.setupDefault()
        presenter.view  = view
        return presenter
    }
    
    func setupDefault() {
        exchangeData = [ExchangeItem(currency: .EUR, amount: 100.0),
                        ExchangeItem(currency: .USD, amount: 100.0),
                        ExchangeItem(currency: .GBP, amount: 100.0)]
    }
    
    func start() {
        currencyManager?.delegate = self
        currencyManager?.start()
    }
    
    func stop() {
        currencyManager?.delegate = nil
        currencyManager?.stop()
    }
    
    func makeExchange(from: Currency, to: Currency, amount: Double) {
        let rate = currencyManager?.rate(from: from, to: to) ?? 0.0
        let differAmount = amount*rate
        
        let fromItem = exchangeData.filter{$0.currency == from}.first
        let toItem = exchangeData.filter{$0.currency == to}.first
        if let fromItem = fromItem, let toItem = toItem {
            if (fromItem.amount < differAmount) {
                //show that is not enough
            } else {
                fromItem.changeAmount(amount: -differAmount)
                toItem.changeAmount(amount: differAmount)
                
                view?.showChanged(fromItem: fromItem, toItem: toItem)
            }
        }
        
        
    }
}

extension ExchangePresenter : CurrencyManagerDelegate {
    func rateChanged() {
       
    }
}
