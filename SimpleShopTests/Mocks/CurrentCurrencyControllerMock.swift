//
//  CurrentCurrencyControllerMock.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleShop

class CurrentCurrencyControllerMock: CurrentCurrencyControllerProtocol {

    var currentCurrency: Currency?
    fileprivate var defaulCurrency: Currency

    init (defaulCurrency: Currency = Currency(name: "USD", rate: 1.0)) {
        self.defaulCurrency = defaulCurrency
    }

    var getDefaultCurrency: Currency {
        return defaulCurrency
    }

    var getCurrency: Currency {
        if let currentCurrency = currentCurrency {
            return currentCurrency
        } else {
            return defaulCurrency
        }
    }

    func setCurrency(currency: Currency) {
        currentCurrency = currency
    }
}
