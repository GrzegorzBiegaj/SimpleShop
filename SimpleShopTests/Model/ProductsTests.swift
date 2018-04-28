//
//  ProductsTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class ProductsTests: XCTestCase {
    
    func testProducts() {

        let products = Products().products
        let product1 = Product(name: "Peas", description: "Fresh green pease", quantity: "1 kg", packageType: .bag, price: 0.95, imageName: "peas")
        let product2 = Product(name: "Eggs", description: "Fresh bio eggs", quantity: "12 pieces", packageType: .dozen, price: 2.10, imageName: "eggs")
        let product3 = Product(name: "Milk", description: "Fresh good milk", quantity: "1 l", packageType: .bottle, price: 1.30, imageName: "milk")
        let product4 = Product(name: "Beans", description: "Fresh good Beans", quantity: "1 kg", packageType: .can, price: 0.73, imageName: "beans")

        XCTAssertEqual(products.count, 4)
        XCTAssertTrue(compare(product1: products[0], product2: product1))
        XCTAssertTrue(compare(product1: products[1], product2: product2))
        XCTAssertTrue(compare(product1: products[2], product2: product3))
        XCTAssertTrue(compare(product1: products[3], product2: product4))
    }

    func compare(product1: Product, product2: Product) -> Bool {

        return product1.name == product2.name &&
            product1.description == product2.description &&
            product1.quantity == product2.quantity &&
            product1.packageType == product2.packageType &&
            product1.price == product2.price &&
            product1.imageName == product2.imageName
    }

}
