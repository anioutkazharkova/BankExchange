//
//  CurrencyManager.swift
//  BankExchange
//
//  Created by azharkova on 28.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

//MARK: service for periodical request of rates 
class CurrencyManager : ICurrencyManager {
    private weak var currencyService = DI.serviceContainer.currencyService
    weak var delegate: CurrencyManagerDelegate?
    
    private var timer: Timer?
    private var _currentRateData: BaseRate?
    
    var currentRateData: BaseRate? {
        get {
            return self._currentRateData
        }
    }
    
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
       self.currencyService?.getCurrentRates { [weak self] (result: ContentResponse<BaseRate>) in
            if let data  = result.content {
                self?._currentRateData = data
                self?.delegate?.rateChanged()
            }
        }
    }
}
