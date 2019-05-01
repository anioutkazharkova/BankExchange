//
//  ExchangeVC.swift
//  BankExchange
//
//  Created by 1 on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController {
    
    @IBOutlet weak var sourceCurrencyList: UICollectionView!
    @IBOutlet weak var distanceCurrencyList: UICollectionView!
    
    var sourceAdapter: ExchangeSource?
    var distanceAdapter: ExchangeSource?
    
    private var presenter: IExchangePresenter?
    
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
    
    func setMenu() {
        let menu = UIBarButtonItem(title: "Exchange", style: .plain, target: self, action: #selector(processExchange))
        self.navigationItem.leftBarButtonItem = menu
    }
    
    @objc func processExchange() {
        let sum = sourceAdapter?.getExchangeSum()
       presenter?.makeExchange(from: sourceAdapter?.selectedItem.currency ?? .EUR, to: distanceAdapter?.selectedItem.currency ?? .EUR, amount: sum ?? 0.0 )
        sourceAdapter?.setNeedResetFields()
        distanceAdapter?.setNeedResetFields()
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
    
}

extension ExchangeVC : ItemSelectedDelegate {
    func selectedItem(index: Int, tag: Int) {
        if tag == 1 {
            distanceAdapter?.pairSelectedIndex = index
            
        } else {
            sourceAdapter?.pairSelectedIndex = index
            
        }
        distanceCurrencyList?.reloadData()
        sourceCurrencyList?.reloadData()
    }
    
    func valueChanged(value: Double) {
        distanceAdapter?.selectedValue = String(format:"+%.2f",value)
        distanceCurrencyList?.reloadData()
    }
}

extension ExchangeVC : IExchangeView {
    
    func loadData(items: [ExchangeItem]) {
        self.sourceAdapter?.updateItems(items: items)
        self.distanceAdapter?.updateItems(items: items)
        
        self.sourceCurrencyList?.reloadData()
        self.distanceCurrencyList?.reloadData()
    }
    
    func showChanged(fromItem: ExchangeItem, toItem: ExchangeItem) {
        
    }
    
    func updateSelected() {
        //берем выбранные по индексам из адаптера и вызываем
       // self.presenter?.makeExchange(from: <#T##Currency#>, to: <#T##Currency#>, amount: <#T##Double#>)
    }
    
}
