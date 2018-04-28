//
//  CurrentCurrencyTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 26.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class CurrentCurrencyTests: XCTestCase {

    let storage = InMemoryStorage.sharedInstance

    override func setUp() {
        super.setUp()
        storage.clearAll()
    }
    
    override func tearDown() {
        super.setUp()
        storage.clearAll()
    }
    
    func testCurrentCurrency() {
        let currentCurrency: CurrentCurrency? = storage.tryRestore()

        XCTAssertNil(currentCurrency)
        let newCurrentCurrency = CurrentCurrency(currency: Currency(name: "test", rate: 123.4))
        storage.store(newCurrentCurrency)
        let readCurrentCurrency: CurrentCurrency? = storage.tryRestore()

        XCTAssertEqual(newCurrentCurrency.currency, readCurrentCurrency?.currency)
    }

    
}
