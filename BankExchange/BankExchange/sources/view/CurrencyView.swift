//
//  CurrencyView.swift
//  BankExchange
//
//  Created by 1 on 01.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit

protocol  TextChangedDelegate : class {
    func textChanged(value: String)
}

class CurrencyView: UIView {
    
    weak var textDelegate: TextChangedDelegate?

    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var rateInfoLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initContent()
    }
    private  func initContent() {
        
        let view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: CurrencyView.self)
        let nib = UINib(nibName: "CurrencyView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        valueField?.isUserInteractionEnabled = true
        valueField?.bringSubviewToFront(view)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        return view
    }
    
    func setInfo(item: ExchangeItem, distanceCurrency: Currency? = nil){
        self.currencyLabel?.text = item.currency.rawValue
        self.amountLabel?.text = String(format:"You have: %.2f",item.amount)
        let rate = self.updateRate(sourceCurrency: item.currency, distanceCurrency: distanceCurrency)
        //item.currentRate = rate 
        self.rateInfoLabel?.text = String(format:"1 = %.2f",rate)
    }
    
    func updateRate(sourceCurrency: Currency, distanceCurrency: Currency? = nil ) -> Double{
        var rate: Double = 0
        if let distance = distanceCurrency {
            rate = RateHelper.shared.rate(from: sourceCurrency, to: distance)
        } else {
            rate = RateHelper.shared.rateFromBase(currency: sourceCurrency)
        }
        return rate
        
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        textDelegate?.textChanged(value: valueField?.text ?? "")
    }
}
