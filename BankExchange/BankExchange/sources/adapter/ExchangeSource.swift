//
//  ExchangeSource.swift
//  BankExchange
//
//  Created by 1 on 01.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation
import UIKit

protocol ItemSelectedDelegate : class {
    func selectedItem(index: Int, tag: Int)
    
    func valueChanged(value: Double)
}

class ExchangeSource : NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var tag: Int = 0
    weak var delegate: ItemSelectedDelegate?
    private var currentExchangeSum:Double = 0.0
    var sourceMode:Bool = true
    var selectedValue: String = ""
    private var isToReset = false
    
    func setNeedResetFields() {
        isToReset = true
        currentExchangeSum = 0
        selectedValue = ""
    }
    
    var pairSelectedIndex: Int = 0{
        didSet {
            self.pairSelected = items[pairSelectedIndex]
        }
    }
    private var pairSelected:ExchangeItem?
    var selectedIndex:Int = 0
    var selectedItem: ExchangeItem {
        get {
            return items[selectedIndex]
        }
    }
    var items = [ExchangeItem]()
    
    func updateItems(items: [ExchangeItem]) {
        self.items = [ExchangeItem]()
        self.items.append(contentsOf: items)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExchangeCell.cellId, for: indexPath) as? ExchangeCell else {
            return UICollectionViewCell()
        }
        let isSelected = indexPath.row == selectedIndex
        cell.setupItem(item: items[indexPath.row], distanceSource: self.pairSelected?.currency ?? .EUR,isSelected: isSelected)
        cell.setEditMode(enabled: sourceMode)
        cell.textDelegate  = isSelected ? self : nil
        
        if isToReset {
            cell.updateForSelected("")
            if indexPath.row == items.count - 1 {
                isToReset = false 
            }
        }else {
        if !sourceMode && isSelected{
            cell.updateForSelected(selectedValue)
        } else if !isSelected {
            cell.updateForSelected("")
        }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate?.selectedItem(index: indexPath.row, tag: tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func getExchangeSum()->Double {
        return  self.currentExchangeSum
    }
    
    func getExchaneSumDist()->Double {
        return  self.currentExchangeSum*RateHelper.shared.rate(from: selectedItem.currency, to: pairSelected?.currency ?? .EUR)
    }
    
}

extension ExchangeSource : TextChangedDelegate{
    func textChanged(value: String) {
        guard !value.isEmpty else {
            return
        }
        self.currentExchangeSum = Double(value) ?? 0.0
        if sourceMode {
            delegate?.valueChanged(value:self.getExchaneSumDist())
        }
    }
}

extension ExchangeSource : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/(UIScreen.main.bounds.width - 40)
        delegate?.selectedItem(index: Int(index), tag: tag)
    }
}
