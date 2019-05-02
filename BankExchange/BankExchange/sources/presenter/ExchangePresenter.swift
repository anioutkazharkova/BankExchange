//
//  ExchangePresenter.swift
//  BankExchange
//
//  Created by azharkova on 29.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

class ExchangePresenter: IExchangePresenter {
    weak var view: IExchangeView?

    var selectedSource: Currency = .EUR
    var selectedDistance: Currency = .EUR
    var selectedAmount: Double = 0.0

    private weak var currencyManager = DI.serviceContainer.currencyManager
    private var exchangeData: [ExchangeItem] = [ExchangeItem]()
    private var sourceData: [ExchangeCardItem] = [ExchangeCardItem]()
    private var distanceData: [ExchangeCardItem] = [ExchangeCardItem]()

    static func setup(view: IExchangeView?) -> IExchangePresenter? {
        let presenter = ExchangePresenter()
        presenter.setupDefault()
        presenter.view  = view
        return presenter
    }

    // MARK: default data
    func setupDefault() {
        exchangeData = [ExchangeItem(currency: .EUR, amount: 100.0),
                        ExchangeItem(currency: .USD, amount: 100.0),
                        ExchangeItem(currency: .GBP, amount: 100.0)]

        prepareData()
    }

    func start() {
        self.view?.loadSourceData(items: sourceData)
        self.view?.loadDistanceData(items: distanceData)
        currencyManager?.delegate = self
        currencyManager?.start()
    }

    func stop() {
        currencyManager?.delegate = nil
        currencyManager?.stop()
    }

    func prepareData() {
        prepareSource()
        prepareDistance()
        updateForRate()
    }

    private  func prepareSource() {
        sourceData = [ExchangeCardItem]()
        for d in exchangeData {
            let item = ExchangeCardItem()
            item.exchangeItem = d
            sourceData.append(item)
        }
    }

    private func prepareDistance() {
        distanceData = [ExchangeCardItem]()
        for d in exchangeData {
            let item = ExchangeCardItem()
            item.exchangeItem = d
            distanceData.append(item)
        }
    }

    // MARK: change data for current rates
    private func updateForRate() {
        for s in sourceData {
            let rate = RateHelper.shared.rate(from: s.exchangeItem?.currency ?? .EUR, to: selectedDistance)
            s.currentRate = rate
            s.pairCurrency = selectedDistance
        }

        for d in distanceData {
            let rate = RateHelper.shared.rate(from: d.exchangeItem?.currency ?? .EUR, to: selectedSource)
            d.currentRate = rate
            d.pairCurrency = selectedSource
        }
        createTitle()
    }

    private func createTitle() {
        let source = sourceData.filter {($0.exchangeItem?.currency ?? .EUR) == selectedSource}.first
        let title = source?.rateInfo() ?? ""
        self.view?.setTitle(title: title)
    }

    func selectSource(index: Int) {
        self.selectedSource = exchangeData[index].currency
        updateForRate()
    }

    func selectDistance(index: Int) {
        self.selectedDistance = exchangeData[index].currency
        updateForRate()
    }

    func changeAmount(amount: Double) {
        self.selectedAmount = amount
        let distance = distanceData.filter {($0.exchangeItem?.currency ?? .EUR)==selectedDistance}.first
        distance?.sumValue = String(format: "+%.2f", amount*(distance?.currentRate ?? 1.0))
        self.view?.loadDistanceData(items: distanceData)

    }

    func makeExchange(amount: Double) {
        self.makeExchange(from: selectedSource, to: selectedDistance, amount: amount)
    }

    private  func makeExchange(from: Currency, to: Currency, amount: Double) {
        let rate = RateHelper.shared.rate(from: from, to: to)
        let differAmount = amount*rate

        let fromItem = exchangeData.filter {$0.currency == from}.first
        let toItem = exchangeData.filter {$0.currency == to}.first
        if let fromItem = fromItem, let toItem = toItem {
            if (fromItem.amount < amount) {
                self.view?.showInfo(message: "You don't have enough money on your account")
            } else {
                fromItem.changeAmount(amount: -amount)
                toItem.changeAmount(amount: differAmount)

                self.view?.showInfo(message: createInfo(differAmount: differAmount))
            }
        }
        prepareSource()
        prepareDistance()
        self.view?.loadSourceData(items: sourceData)
        self.view?.loadDistanceData(items: distanceData)

    }

    private func createInfo(differAmount: Double) -> String {
        let distance = exchangeData.filter {($0.currency)==selectedDistance}.first
        let distanceBalance = distance?.amount ?? 0.0
        var accountInfo = ""
        for d in exchangeData {
            accountInfo.append ("\(d.currency.symbol) \(String(format: "%.2f\r\n", d.amount))")
        }
        return "Receipt \(selectedDistance.symbol) \(String(format: "%.2f", differAmount)) to account \(selectedDistance.rawValue) \r\n Available balance: \(selectedDistance.symbol)\(String(format: "%.2f", distanceBalance)) Available accounts:\r\n \(accountInfo)"
    }
}

extension ExchangePresenter: CurrencyManagerDelegate {
    func rateChanged() {
        if let rates = currencyManager?.currentRateData?.rates {
            for item in self.exchangeData {
                item.baseRate = rates[item.currency] ?? 1.0
            }
        }
        self.updateForRate()
        self.view?.loadSourceData(items: sourceData)
        self.view?.loadDistanceData(items: distanceData)
    }
}
