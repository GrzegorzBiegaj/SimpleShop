//
//  BasketControllerMock.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleShop

class BasketControllerMock: BasketControllerProtocol {

    var basketStorage: Basket

    init (basket: Basket = Basket(items: [])) {
        self.basketStorage = basket
    }

    func addOrUpdate(product: Product, amount: Int) -> Bool {
        return true
    }

    func remove(product: Product) -> Bool {
        let items = basketStorage.items.filter { $0.product != product }
        basketStorage.items = items
        return true
    }

    func getValue(product: Product) -> Int? {
        return 0
    }

    func calculateBasket(currency: Currency) -> Float {
        return basketStorage.items.reduce(0.0, { $0 + ($1.product.price * Float($1.amount) * currency.rate) })
    }

    func removeAll() {
    }

    var basket: Basket {
        return basketStorage
    }

    
}
