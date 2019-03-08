//
//  BasketControllerTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 27.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class BasketControllerTests: XCTestCase {
    
    let storage = InMemoryStorage.sharedInstance

    override func setUp() {
        super.setUp()
        storage.clearAll()
    }

    override func tearDown() {
        super.setUp()
        storage.clearAll()
    }
    
    func testAdd1() {

        let product = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketController = BasketController()
        let basketItem = BasketItem(product: product, amount: 5)

        XCTAssertNotNil(basketController.basket)
        XCTAssertEqual(basketController.basket.items.count, 0)
        XCTAssertEqual(basketController.basket.items, [])

        basketController.addOrUpdate(product: product, amount: 5)
        XCTAssertEqual(basketController.basket.items.count, 1)
        XCTAssertEqual(basketController.basket.items, [basketItem])
    }

    func testAddX() {

        let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "xyz", description: "kkkk", quantity: "1l", packageType: .bottle, price: 2.34)
        let product3 = Product(name: "iiii", description: "sss", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketController = BasketController()

        let basketItem1 = BasketItem(product: product1, amount: 5)
        let basketItem2 = BasketItem(product: product2, amount: 1)
        let basketItem3 = BasketItem(product: product3, amount: 10)

        let res1 = basketController.addOrUpdate(product: product1, amount: 5)
        let res2 = basketController.addOrUpdate(product: product2, amount: 1)
        let res3 = basketController.addOrUpdate(product: product3, amount: 10)

        XCTAssertTrue(res1)
        XCTAssertTrue(res2)
        XCTAssertTrue(res3)
        XCTAssertEqual(basketController.basket.items.count, 3)
        XCTAssertEqual(basketController.basket.items, [basketItem1, basketItem2, basketItem3])
    }

    func testUpdate() {

        let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "xyz", description: "kkkk", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketController = BasketController()

        let basketItem2 = BasketItem(product: product2, amount: 1)
        let basketItem3 = BasketItem(product: product1, amount: 6)

        let res1 = basketController.addOrUpdate(product: product1, amount: 5)
        let res2 = basketController.addOrUpdate(product: product2, amount: 1)
        let res3 = basketController.addOrUpdate(product: product1, amount: 6)

        XCTAssertTrue(res1)
        XCTAssertTrue(res2)
        XCTAssertFalse(res3)
        XCTAssertEqual(basketController.basket.items.count, 2)
        XCTAssertEqual(basketController.basket.items, [basketItem3, basketItem2])
        XCTAssertEqual(basketController.basket.items[0].amount, 6)
    }

    func testRemove() {
        let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "xyz", description: "kkkk", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketController = BasketController()

        let basketItem1 = BasketItem(product: product1, amount: 5)
        let basketItem2 = BasketItem(product: product2, amount: 1)

        basketController.addOrUpdate(product: product1, amount: 5)
        basketController.addOrUpdate(product: product2, amount: 1)
        XCTAssertEqual(basketController.basket.items.count, 2)
        XCTAssertEqual(basketController.basket.items, [basketItem1, basketItem2])

        basketController.remove(product: product1)
        XCTAssertEqual(basketController.basket.items.count, 1)
        XCTAssertEqual(basketController.basket.items, [basketItem2])
    }

    func testRemoveAll() {
        let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "xyz", description: "kkkk", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketController = BasketController()

        let basketItem1 = BasketItem(product: product1, amount: 5)
        let basketItem2 = BasketItem(product: product2, amount: 1)

        basketController.addOrUpdate(product: product1, amount: 5)
        basketController.addOrUpdate(product: product2, amount: 1)
        XCTAssertEqual(basketController.basket.items.count, 2)
        XCTAssertEqual(basketController.basket.items, [basketItem1, basketItem2])

        basketController.removeAll()
        XCTAssertEqual(basketController.basket.items.count, 0)
        XCTAssertEqual(basketController.basket.items, [])
    }

    func testGetValue() {
        let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "bbbb", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let basketController = BasketController()
        basketController.addOrUpdate(product: product1, amount: 5)
        XCTAssertEqual(basketController.getValue(product: product1), 5)
        XCTAssertNil(basketController.getValue(product: product2))
    }

    func testCalculateBasket() {
        let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
        let product2 = Product(name: "xyz", description: "kkkk", quantity: "1l", packageType: .bottle, price: 1.88)
        let product3 = Product(name: "iiii", description: "efgh", quantity: "1l", packageType: .bottle, price: 0.66)
        let product4 = Product(name: "ooo", description: "kkkk", quantity: "1l", packageType: .bottle, price: 4.77)
        let basketController = BasketController()

        basketController.addOrUpdate(product: product1, amount: 5)
        basketController.addOrUpdate(product: product2, amount: 1)
        basketController.addOrUpdate(product: product3, amount: 7)
        basketController.addOrUpdate(product: product4, amount: 4)

        let currency = Currency(name: "VXU", rate: 1.65)

        var value: Float = (2.34 * 5) + 1.88 + (0.66 * 7)
        value += (4.77 * 4)
        value *= 1.65

        XCTAssertEqual(basketController.calculateBasket(currency: currency).rounded(.down), value.rounded(.down))
    }

}
