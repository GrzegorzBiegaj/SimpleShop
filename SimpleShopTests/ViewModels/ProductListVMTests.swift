//
//  ProductListVMTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class ProductListVMTests: XCTestCase {

    let products = Products().products
    let productsTests = ProductsTests()

    var productListVM: ProductListVM = {
        let basketController = BasketControllerMock()
        let constantsController = ConstantsControllerMock()
        let currentCurrencyController = CurrentCurrencyControllerMock()

        return ProductListVM(basketController: basketController, constantsController: constantsController, currentCurrencyController: currentCurrencyController)
    }()
    
    func testShowProductsUpdateIncrease() {

        var showProducts = productListVM.showProducts

        let showProduct1 = ShowProduct(product: products[0], amount: 1, shownPrice: "0.95 $", maxAmount: ConstantsControllerMock().maxProductAmount)
        let showProduct2 = ShowProduct(product: products[1], amount: 1, shownPrice: "2.10 $", maxAmount: ConstantsControllerMock().maxProductAmount)
        let showProduct3 = ShowProduct(product: products[2], amount: 1, shownPrice: "1.30 $", maxAmount: ConstantsControllerMock().maxProductAmount)
        let showProduct4 = ShowProduct(product: products[3], amount: 1, shownPrice: "0.73 $", maxAmount: ConstantsControllerMock().maxProductAmount)

        XCTAssertEqual(showProducts.count, 4)
        XCTAssertTrue(compare(showProduct1: showProducts[0], showProduct2: showProduct1))
        XCTAssertTrue(compare(showProduct1: showProducts[1], showProduct2: showProduct2))
        XCTAssertTrue(compare(showProduct1: showProducts[2], showProduct2: showProduct3))
        XCTAssertTrue(compare(showProduct1: showProducts[3], showProduct2: showProduct4))

        productListVM.updateAmount(showProduct: showProducts[0], amount: 3)
        showProducts = productListVM.showProducts
        showProduct1.amount = 3
        XCTAssertTrue(compare(showProduct1: showProducts[0], showProduct2: showProduct1))

        XCTAssertTrue(productListVM.canIncreaseProduct(showProduct: showProducts[0]))

        productListVM.updateAmount(showProduct: showProducts[0], amount: 11)
        XCTAssertFalse(productListVM.canIncreaseProduct(showProduct: showProducts[0]))
    }

    // Info: In the final project strings will be replaced to the string keys
    func testTranslations() {

        let maxAmount = ConstantsControllerMock().maxProductAmount
        XCTAssertEqual(productListVM.title, "Product list")
        XCTAssertEqual(productListVM.messageTitle, "Message")
        XCTAssertEqual(productListVM.alertTitle, "Warning")
        XCTAssertEqual(productListVM.okButtonTitle, "OK")
        XCTAssertEqual(productListVM.cancelButtonTitle, "Cancel")
        XCTAssertEqual(productListVM.confirmationMessage(value: 5), "Added 5 pieces of product")
        XCTAssertEqual(productListVM.errorMessage, "Can't add more products. Max number is limited to \(maxAmount)")
        XCTAssertEqual(productListVM.alertMessage(value: 7), "Product is already added. There are already 7 pieces. Would you like to add it again?")
    }

    func compare(showProduct1: ShowProduct, showProduct2: ShowProduct) -> Bool {
        return productsTests.compare(product1: showProduct1.product, product2: showProduct2.product) &&
            showProduct1.amount == showProduct2.amount &&
            showProduct1.maxAmount == showProduct2.maxAmount &&
            showProduct1.shownPrice == showProduct2.shownPrice
    }

    

    
}
