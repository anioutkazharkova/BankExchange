//
//  ExchangeVC.swift
//  BankExchange
//
//  Created by 1 on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController {
    
    private var presenter: IExchangePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ExchangePresenter.setup(view: self)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ExchangeVC : IExchangeView {
    func showChanged(fromItem: ExchangeItem, toItem: ExchangeItem) {
        
    }
    
    func updateSelected() {
        //берем выбранные по индексам из адаптера и вызываем
       // self.presenter?.makeExchange(from: <#T##Currency#>, to: <#T##Currency#>, amount: <#T##Double#>)
    }
    
}
