//
//  BasketVM.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

class ShowBasketItem {
    let basketItem: BasketItem
    let shownPrice: String
    let shownSum: String
    let maxAmount: Int

    init(basketItem: BasketItem, shownPrice: String, shownSum: String, maxAmount: Int) {
        self.basketItem = basketItem
        self.shownPrice = shownPrice
        self.shownSum = shownSum
        self.maxAmount = maxAmount
    }
}

class BasketVM {

    enum CurrencyUpdateResponse {
        case success(Currency)
        case error(ResponseError)
    }

    fileprivate let basketController: BasketControllerProtocol
    fileprivate let constantsController: ConstantsControllerProtocol
    fileprivate let currentCurrencyController: CurrentCurrencyControllerProtocol
    fileprivate let currencyListController: CurrencyListControllerProtocol

    // Mark: Public interface

    var showBasket: [ShowBasketItem] = []

    init (basketController: BasketControllerProtocol = BasketController(),
          constantsController: ConstantsControllerProtocol = ConstantsController(),
          currentCurrencyController: CurrentCurrencyControllerProtocol = CurrentCurrencyController(),
          currencyListController: CurrencyListControllerProtocol = CurrencyListController()) {

        self.basketController = basketController
        self.constantsController = constantsController
        self.currentCurrencyController = currentCurrencyController
        self.currencyListController = currencyListController
        refreshData()
    }

    func refreshData() {
        showBasket = basketController.basket.items.map {
            ShowBasketItem(basketItem: $0,
                           shownPrice: $0.product.getPriceString(currency: currentCurrencyController.getCurrency),
                           shownSum: $0.getPriceTotalString(currency: currentCurrencyController.getCurrency),
                           maxAmount: constantsController.maxProductAmount) }
    }

    func findIndex(product: Product) -> Int? {
        for (index, item) in showBasket.enumerated() {
            if item.basketItem.product == product {
                return index
            }
        }
        return nil
    }

    func getTotalPrice() -> String {
        let currency = currentCurrencyController.getCurrency
        let price =  basketController.calculateBasket(currency: currency)
        return price.currency(code: currency.name)
    }

    func updateCurrency(currency: Currency, closure: @escaping (CurrencyUpdateResponse) -> ()) {
        currencyListController.currencyList { (response) in
            switch response {
            case .success(let currencyList):
                guard let currency = currencyList.list.first(where: { $0.name == currency.name }) else {
                    closure(CurrencyUpdateResponse.error(ResponseError.decodeError))
                    return
                }
                closure(CurrencyUpdateResponse.success(currency))
            case .error(let error):
                closure(CurrencyUpdateResponse.error(error))
            }
        }
    }

    func addOrUpdate(product: Product, amount: Int) {
        basketController.addOrUpdate(product: product, amount: amount)
        refreshData()
    }

    func remove(product: Product) {
        basketController.remove(product: product)
        refreshData()
    }

    func removeAll() {
        basketController.removeAll()
        refreshData()
    }

    // Mark: Translations
    let title = "Basket"

    let errorTitle = "Error"
    let warningTitle = "Warning"
    let okButtonTitle = "OK"
    let cancelButtonTitle = "OK"
    let warningMessage = "Are you sure to delete all the products from the basket?"

    func errorMessage(error: Error) -> String {
        return "Network error: \(error)"
    }
    
    let successTitle = "Info"
    let successMessage = "Basket is up to date"
}
