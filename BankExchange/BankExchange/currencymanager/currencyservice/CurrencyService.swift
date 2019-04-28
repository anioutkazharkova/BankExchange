//
//  CurrencyService.swift
//  BankExchange
//
//  Created by 1 on 28.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

class CurrencyService: ICurrencyService {
     private weak var networkService = DI.container.networkService
    
    
    func getCurrentRates(completion:@escaping(ContentResponse<BaseRate>)->Void) {
        let url = Requests.latest
        self.networkService?.request(url: url.rawValue, parameters: [:], method: .get,completion:  completion)
    }
}
