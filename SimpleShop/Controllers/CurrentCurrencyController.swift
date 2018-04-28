//
//  CurrentCurrencyController.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol CurrentCurrencyControllerProtocol {

    var getDefaultCurrency: Currency { get }
    var getCurrency: Currency { get }
    func setCurrency(currency: Currency)
}

class CurrentCurrencyController: CurrentCurrencyControllerProtocol {
    
    fileprivate let storage = InMemoryStorage.sharedInstance
    fileprivate let constantsController: ConstantsControllerProtocol

    // Mark: Public interface
    
    init (constantsController: ConstantsControllerProtocol = ConstantsController()) {
        self.constantsController = constantsController
    }

    var getDefaultCurrency: Currency {
        return Currency(name: constantsController.defaultCurrency, rate: 1.0)
    }

    var getCurrency: Currency {
        guard let currentCurrency: CurrentCurrency = storage.tryRestore() else {
            return getDefaultCurrency
        }
        return currentCurrency.currency
    }

    func setCurrency(currency: Currency) {
        let currentCurrency = CurrentCurrency(currency: currency)
        storage.store(currentCurrency)
    }

}
