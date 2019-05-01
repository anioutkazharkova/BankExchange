//
//  IExchangePresenter.swift
//  BankExchange
//
//  Created by 1 on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol IExchangePresenter {
    var view: IExchangeView? {get set}
      func start()
    func stop()
     func makeExchange(from: Currency, to: Currency, amount: Double) 
}
