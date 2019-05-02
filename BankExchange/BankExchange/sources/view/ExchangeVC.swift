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
    
    @IBOutlet weak var sourceCurrencyList: UICollectionView!
    @IBOutlet weak var distanceCurrencyList: UICollectionView!
    
    var sourceAdapter: ExchangeSource?
    var distanceAdapter: ExchangeSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        presenter = ExchangePresenter.setup(view: self)
        sourceAdapter = ExchangeSource()
        sourceAdapter?.tag = 1
        distanceAdapter = ExchangeSource()
        distanceAdapter?.tag = 2
        distanceAdapter?.sourceMode = false
        
        sourceCurrencyList?.register(UINib(nibName: ExchangeCell.cellId, bundle: nil), forCellWithReuseIdentifier: ExchangeCell.cellId)
        distanceCurrencyList?.register(UINib(nibName: ExchangeCell.cellId, bundle: nil), forCellWithReuseIdentifier: ExchangeCell.cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.sourceCurrencyList?.delegate = sourceAdapter
        self.sourceCurrencyList?.dataSource = sourceAdapter
        sourceAdapter?.delegate = self
        distanceAdapter?.delegate = self
        
        self.distanceCurrencyList?.delegate = distanceAdapter
        self.distanceCurrencyList?.dataSource = distanceAdapter
        setMenu()
        presenter?.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.stop()
        self.sourceCurrencyList?.delegate = nil
        self.sourceCurrencyList?.dataSource = nil
        
        self.distanceCurrencyList?.delegate = nil
        self.distanceCurrencyList?.dataSource = nil
        super.viewWillDisappear(animated)
    }
    
    func setMenu() {
        let menu = UIBarButtonItem(title: "Exchange", style: .plain, target: self, action: #selector(processExchange))
        self.navigationItem.rightBarButtonItem = menu
    }
    
    @objc func processExchange() {
        let sum = sourceAdapter?.currentExchangeSum ?? 0.0
        presenter?.makeExchange(amount: sum)
    }
    
}

extension ExchangeVC : ItemSelectedDelegate {
    func selectedItem(index: Int, tag: Int) {
        if tag == 1 {
            presenter?.selectSource(index: index)
        } else {
            presenter?.selectDistance(index: index)
            
        }
        distanceCurrencyList?.reloadData()
        sourceCurrencyList?.reloadData()
    }
    
    func valueChanged(value: Double) {
        self.presenter?.changeAmount(amount: value)
    }
}

extension ExchangeVC : IExchangeView {
    func setTitle(title: String) {
        self.title = title
    }
    
    func loadSourceData(items: [ExchangeCardItem]) {
        self.sourceAdapter?.updateItems(items: items)
        self.sourceCurrencyList?.reloadData()
        
    }
    
    func loadDistanceData(items:[ExchangeCardItem]) {
        self.distanceAdapter?.updateItems(items: items)
        self.distanceCurrencyList?.reloadData()
    }
    
    func showInfo(message: String) {
        self.present(DialogHelper.shared.dialog(title: "", message: message), animated: true, completion: nil)
    }
}
