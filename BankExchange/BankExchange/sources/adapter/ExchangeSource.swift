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
    var currentExchangeSum:Double = 0.0
    var sourceMode:Bool = true
    
    var selectedIndex:Int = 0
    var items = [ExchangeCardItem]()
    
    func updateItems(items: [ExchangeCardItem]) {
        self.items = [ExchangeCardItem]()
        self.items.append(contentsOf: items)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExchangeCell.cellId, for: indexPath) as? ExchangeCell else {
            return UICollectionViewCell()
        }
        let isSelected = indexPath.row == selectedIndex
            cell.setEditMode(enabled: sourceMode)
        cell.setupItem(item: items[indexPath.row], isSelected: isSelected)
    
        cell.textDelegate  = isSelected ? self : nil
        
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
    
}

extension ExchangeSource : TextChangedDelegate{
    func textChanged(value: String) {
        guard !value.isEmpty else {
            return
        }
        self.currentExchangeSum = value.getAmount()
        if sourceMode {
            delegate?.valueChanged(value:currentExchangeSum)
        }
    }
}

extension ExchangeSource : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/(UIScreen.main.bounds.width - 40)
        selectedIndex = Int(index)
        delegate?.selectedItem(index: selectedIndex, tag: tag)
    }
}
