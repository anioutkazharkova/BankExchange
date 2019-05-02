//
//  ICurrencyService.swift
//  BankExchange
//
//  Created by azharkova on 28.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol ICurrencyService: class {
    func getCurrentRates(completion:@escaping(ContentResponse<BaseRate>) -> Void)
}
