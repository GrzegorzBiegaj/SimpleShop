//
//  BasketTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 26.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class BasketTests: XCTestCase {

    let storage = InMemoryStorage.sharedInstance

    override func setUp() {
        super.setUp()
        storage.clearAll()
    }

    override func tearDown() {
        super.setUp()
        storage.clearAll()
    }
    
    func testBasketItem() {
        let product = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketItem = BasketItem(product: product, amount: 5)
        let basketItem2 = BasketItem(product: product, amount: 5)
        let currency = Currency(name: "EUR", rate: 0.99)

        XCTAssertEqual(basketItem.getPriceTotalString(currency: currency), "11.58 €")
        XCTAssertTrue(basketItem == basketItem2)
    }

    func testBasket() {
        let emptyBasket: Basket? = storage.tryRestore()

        XCTAssertNil(emptyBasket)

        let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "xyz", description: "kkkk", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketItem1 = BasketItem(product: product1, amount: 5)
        let basketItem2 = BasketItem(product: product2, amount: 7)
        let newBasket = Basket(items: [basketItem1, basketItem2])
        storage.store(newBasket)
        let readBasket: Basket? = storage.tryRestore()
        
        XCTAssertEqual(newBasket.items, readBasket?.items)
    }
    
}
