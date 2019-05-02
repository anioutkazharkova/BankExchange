//
//  ExchangeCell.swift
//  BankExchange
//
//  Created by azharkova on 01.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit

class ExchangeCell: UICollectionViewCell {
    
    static let cellId = "ExchangeCell"
    var editMode: Bool = true
    
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
    
    
    func setupItem(item: ExchangeCardItem,isSelected: Bool = false) {
        self.currencyView?.setInfo(item: item)
        if (isSelected) {
            currencyView?.valueField?.delegate = self
            currencyView?.valueField?.text = item.sumValue
            
        }else {
            currencyView?.valueField?.text = ""
            currencyView?.valueField?.delegate = nil
        }
    }
    
    func setEditMode(enabled: Bool) {
        editMode = enabled
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

