//
//  BaseRate.swift
//  BankExchange
//
//  Created by 1 on 28.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseRate : Mappable, Codable {
    
    var base: Currency = .EUR //EURO
    var rates: [Currency:Double] = [Currency:Double]()
    var date:Date = Date()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        var rawRates = [String:Double]()
        
        base <- (map["base"], EnumTransform<Currency>())
        rawRates <- map["rates"]
        for (key, value) in rawRates {
            if let currency = Currency(rawValue: key) {
                rates[currency] = value
            }
        }
    }
}
