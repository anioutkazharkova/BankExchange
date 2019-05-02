//
//  String+Double.swift
//  BankExchange
//
//  Created by azharkova on 02.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

extension String {
    func getFormatter() -> NumberFormatter {
        let format = NumberFormatter.init()
        format.decimalSeparator = "."
        format.maximumFractionDigits = 2
        format.minusSign = "-"
        format.plusSign = "+"
        return format
    }

    func getAmount() -> Double {
        let valueString = self.replacingOccurrences(of: "-", with: "")
        return getFormatter().number(from: valueString)?.doubleValue ?? 0.0
    }

    func getValueString() -> String {
        return String(format: "-%d", Int(self.getAmount()))
    }
}
