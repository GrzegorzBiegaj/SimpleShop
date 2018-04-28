//
//  ConstantsControllerTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 27.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class ConstantsControllerTests: XCTestCase {

    func testJsonratesKey() {
        let constantsController = ConstantsController()
        XCTAssertEqual(constantsController.jsonratesKey, "79f5f300344327e6f02a38b89e80e382")
    }

    func testDefaultCurrency() {
        let constantsController = ConstantsController()
        XCTAssertEqual(constantsController.defaultCurrency, "USD")
    }

    func testMaxProductAmount() {
        let constantsController = ConstantsController()
        XCTAssertEqual(constantsController.maxProductAmount, 10)
    }
    
}
