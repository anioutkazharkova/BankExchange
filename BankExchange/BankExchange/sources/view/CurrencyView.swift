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
    
    func setInfo(item: ExchangeCardItem){
        let symbol = (item.exchangeItem?.currency ?? .EUR).symbol
        self.currencyLabel?.text = (item.exchangeItem?.currency ?? .EUR).rawValue
        self.amountLabel?.text = item.amountInfo()
        self.rateInfoLabel?.text = item.rateInfo()
    }
    
    
    @IBAction func valueChanged(_ sender: Any) {
       
        textDelegate?.textChanged(value: valueField?.text ?? "")
        let valueString = valueField?.text?.getValueString() ?? ""
        self.valueField?.text = valueString
    }
}
