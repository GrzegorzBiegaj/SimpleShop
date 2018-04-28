//
//  CurrentCurrencyControllerTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class CurrentCurrencyControllerTests: XCTestCase {
    
    let storage = InMemoryStorage.sharedInstance
    let mockConstant = ConstantsControllerMock(jsonratesKey: "1234", defaultCurrency: "USD", MaxProductAmount: 100)


    override func setUp() {
        super.setUp()
        storage.clearAll()
    }

    override func tearDown() {
        super.setUp()
        storage.clearAll()
    }

    func testGetDefaultCurrency() {

        let currentCurrencyController = CurrentCurrencyController(constantsController: mockConstant)
        let currency = currentCurrencyController.getCurrency

        XCTAssertEqual(currency, Currency(name: "USD", rate: 1.0))
    }
    
    func testGetSetCurrency() {

        let currentCurrencyController = CurrentCurrencyController(constantsController: mockConstant)
        let currency = currentCurrencyController.getCurrency
        XCTAssertEqual(currency, Currency(name: "USD", rate: 1.0))

        let newCurrency = Currency(name: "ABC", rate: 8.99)
        currentCurrencyController.setCurrency(currency: newCurrency)
        let updatedCurrency = currentCurrencyController.getCurrency
        XCTAssertEqual(updatedCurrency, newCurrency)
    }
    
    
}
