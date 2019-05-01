//
//  ExchangeCell.swift
//  BankExchange
//
//  Created by 1 on 01.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit

class ExchangeCell: UICollectionViewCell {
    
    static let cellId = "ExchangeCell"
    
    weak var textDelegate: TextChangedDelegate? {
        didSet {
            self.currencyView?.textDelegate = textDelegate
        }
    }
    
    @IBOutlet weak var currencyView: CurrencyView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
        self.currencyView?.isUserInteractionEnabled = true
    }
    
    
    func setupItem(item: ExchangeItem, distanceSource:Currency, isSelected: Bool = false) {
        self.currencyView?.setInfo(item: item,distanceCurrency: distanceSource)
        if (isSelected) {
            currencyView?.valueField?.delegate = self
        }else {
            currencyView?.valueField?.text = nil
            currencyView?.valueField?.delegate = nil
        }
    }
    
    func updateForSelected(_ value: String){
        currencyView?.valueField?.text = value 
    }
    
    func setEditMode(enabled: Bool) {
        currencyView?.valueField?.isEnabled = enabled
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

extension ExchangeCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

