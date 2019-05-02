//
//  DialogHelper.swift
//  BankExchange
//
//  Created by 1 on 02.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation
import  UIKit

class DialogHelper {
    static let shared = DialogHelper()
    private init() {}
    
    func dialog(title: String, message: String)->UIAlertController  {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return dialog
    }
}
