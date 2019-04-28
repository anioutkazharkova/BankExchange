//
//  CurrencyManager.swift
//  BankExchange
//
//  Created by 1 on 28.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

class CurrencyManager : ICurrencyManager {
    weak var delegate: CurrencyManagerDelegate?
    
    private var timer: Timer?
    private var currentRateData: BaseRate?
    
    func start() {
        startTimer()
    }
    
    func stop() {
        stopTimer()
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 30,
                                     target: self,
                                     selector:#selector(requestRate),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
   @objc private func requestRate() {
    CurrencyService().getCurrentRates { [weak self] (result: ContentResponse<BaseRate>) in
        if let data  = result.content {
            self?.currentRateData = data
        }
    }
    }
    
    func rateFromBase(currency: Currency) -> Double {
        if let rate = currentRateData {
            if (currency == rate.base) {
                return 1
            } else {
                return rate.rates[currency] ?? 0.0
            }
        }
        return 0.0
    }
    
    func rate(from currency: Currency, to: Currency) -> Double {
        let sourceRate = rateFromBase(currency: currency)
        let distanceRate = rateFromBase(currency: to)
        
        return sourceRate > 0 ?  distanceRate/sourceRate : 0.0
    }
    
}
