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
    
    
    func getCurrentRates() {
        let url = Requests.latest
        self.networkService?.request(url: url.rawValue, parameters: [:], method: .get){ [weak self]
            (result: ContentResponse<BaseRate>) in
            if let content = result.content {
                var rate = content
            }
            
        }
    }
}
