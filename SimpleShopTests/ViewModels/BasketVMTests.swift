//
//  BasketVMTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class BasketVMTests: XCTestCase {

    let product1 = Product(name: "abcd", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)
    let product2 = Product(name: "bbbb", description: "efgh", quantity: "1l", packageType: .bottle, price: 2.34)

    func testShowBasketRefreshData() {

        let basketVM = createBasketVM()

        var showBasket = basketVM.showBasket
        XCTAssertEqual(showBasket.count, 2)
        XCTAssertEqual(showBasket[0].basketItem, BasketItem(product: product1, amount: 10))
        XCTAssertEqual(showBasket[1].basketItem, BasketItem(product: product2, amount: 8))
        basketVM.remove(product: product1)
        basketVM.refreshData()
        showBasket = basketVM.showBasket
        XCTAssertEqual(showBasket.count, 1)
        XCTAssertEqual(showBasket[0].basketItem, BasketItem(product: product2, amount: 8))
    }

    func testGetTotalPrice() {

        let basket = Basket(items: [
            BasketItem(product: product1, amount: 10),
            BasketItem(product: product2, amount: 8)])
        let basketController = BasketControllerMock(basket: basket)
        let constantsController = ConstantsControllerMock()
        let currentCurrencyController = CurrentCurrencyControllerMock()
        let currencyListController = CurrencyListController()

        let basketVM = BasketVM(basketController: basketController, constantsController: constantsController, currentCurrencyController: currentCurrencyController, currencyListController: currencyListController)

        XCTAssertEqual(basketVM.getTotalPrice(), "$42.12")
        currentCurrencyController.currentCurrency = Currency(name: "XXX", rate: 9.99)
        XCTAssertEqual(basketVM.getTotalPrice(), "XXX420.78")
    }

    func testFindIndex() {

        let basketVM = createBasketVM()
        XCTAssertEqual(basketVM.findIndex(product: product2), 1)
        XCTAssertEqual(basketVM.findIndex(product: product1), 0)
    }

    // Info: In the final project strings will be replaced to the string keys
    func testTranslations() {
        let basketVM = createBasketVM()
        XCTAssertEqual(basketVM.title, "Basket")
        XCTAssertEqual(basketVM.errorTitle, "Error")
        XCTAssertEqual(basketVM.warningTitle, "Warning")
        XCTAssertEqual(basketVM.okButtonTitle, "OK")
        XCTAssertEqual(basketVM.cancelButtonTitle, "OK")
        XCTAssertEqual(basketVM.warningMessage, "Are you sure to delete all the products from the basket?")
        XCTAssertEqual(basketVM.errorMessage(error: ResponseError.decodeError), "Network error: decodeError")
        XCTAssertEqual(basketVM.successTitle, "Info")
        XCTAssertEqual(basketVM.successMessage, "Basket is up to date")
    }

    func createBasketVM() -> BasketVM {

        let basket = Basket(items: [
            BasketItem(product: product1, amount: 10),
            BasketItem(product: product2, amount: 8)])
        let basketController = BasketControllerMock(basket: basket)
        let constantsController = ConstantsControllerMock()
        let currentCurrencyController = CurrentCurrencyControllerMock()
        let currencyListController = CurrencyListController()

        return BasketVM(basketController: basketController, constantsController: constantsController, currentCurrencyController: currentCurrencyController, currencyListController: currencyListController)
    }

    
}
