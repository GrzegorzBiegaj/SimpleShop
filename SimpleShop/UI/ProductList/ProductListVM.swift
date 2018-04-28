//
//  ProductListVM.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

class ShowProduct {
    let product: Product
    var amount: Int
    let shownPrice: String
    let maxAmount: Int

    init(product: Product, amount: Int, shownPrice: String, maxAmount: Int) {
        self.product = product
        self.amount = amount
        self.shownPrice = shownPrice
        self.maxAmount = maxAmount
    }
}

class ProductListVM {

    fileprivate let basketController: BasketControllerProtocol
    fileprivate let constantsController: ConstantsControllerProtocol
    fileprivate let currentCurrencyController: CurrentCurrencyControllerProtocol

    // Mark: Public interface
    
    init(basketController: BasketControllerProtocol = BasketController(),
         constantsController: ConstantsControllerProtocol = ConstantsController(),
         currentCurrencyController: CurrentCurrencyControllerProtocol = CurrentCurrencyController()) {

        self.basketController = basketController
        self.constantsController = constantsController
        self.currentCurrencyController = currentCurrencyController

        showProducts = products.map {
            ShowProduct(product: $0,
                        amount: 1,
                        shownPrice: $0.getPriceString(currency: currentCurrencyController.getDefaultCurrency),
                        maxAmount: constantsController.maxProductAmount) }
    }

    var showProducts: [ShowProduct] = []

    func updateAmount(showProduct: ShowProduct, amount: Int) {
        guard let updatedShowProduct = showProducts.first(where: { $0.product == showProduct.product }) else { return }
        updatedShowProduct.amount = amount
    }

    func canIncreaseProduct(showProduct: ShowProduct) -> Bool {
        guard let basketAmount = basketController.getValue(product: showProduct.product) else { return true }
        return constantsController.maxProductAmount >= basketAmount + showProduct.amount
    }

    // Mark: Translations
    let title = "Product list"
    let messageTitle = "Message"
    let alertTitle = "Warning"
    let okButtonTitle = "OK"
    let cancelButtonTitle = "Cancel"

    func confirmationMessage(value: Int) -> String {
        return "Added \(value) pieces of product"
    }
    
    var errorMessage: String {
        return "Can't add more products. Max number is limited to \(constantsController.maxProductAmount)"
    }

    func alertMessage(value: Int) -> String {
        return "Product is already added. There are already \(value) pieces. Would you like to add it again?"
    }

    // MARK: Private
    
    fileprivate var products: [Product] {
        let products = Products()
        return products.products
    }

}
