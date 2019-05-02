//
//  IExchangePresenter.swift
//  BankExchange
//
//  Created by azharkova on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol IExchangePresenter {
    var view: IExchangeView? {get set}
      func start()
    func stop()
     func makeExchange(amount: Double)
    func selectSource(index: Int)
    func selectDistance(index: Int)
    func changeAmount(amount: Double)
}
