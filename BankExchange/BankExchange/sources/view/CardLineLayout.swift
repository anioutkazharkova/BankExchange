//
//  CardLineLayout.swift
//  BankExchange
//
//  Created by azharkova on 01.05.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation
import UIKit

class CardLineLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override init() {
        super.init()
        initContent()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initContent()
    }
    func initContent() {
        scrollDirection=UICollectionView.ScrollDirection.horizontal
        minimumLineSpacing=0
        minimumInteritemSpacing=20
        sectionInset=UIEdgeInsets.zero
        self.footerReferenceSize = CGSize.zero
        self.headerReferenceSize = CGSize.zero
        self.itemSize = CGSize(width: UIScreen.main.bounds.size.width-40, height: 200.0)
    }

}
