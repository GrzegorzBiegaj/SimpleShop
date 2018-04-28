//
//  ProductTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 26.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class ProductTests: XCTestCase {
    
    func testProduct() {
        let product = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product3 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34, imageName: "aa")
        let currency = Currency(name: "USD", rate: 1.33)

        XCTAssertEqual(product.getPriceString(currency: currency), "3.11 $")
        XCTAssertFalse(product == product2)
        XCTAssertFalse(product2 == product3)
    }
}
