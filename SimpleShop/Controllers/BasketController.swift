//
//  BasketController.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol BasketControllerProtocol {

    @discardableResult
    func addOrUpdate(product: Product, amount: Int) -> Bool
    @discardableResult
    func remove(product: Product) -> Bool
    func getValue(product: Product) -> Int?
    func calculateBasket(currency: Currency) -> Float
    func removeAll()

    var basket: Basket { get }
}

class BasketController: BasketControllerProtocol {

    fileprivate let storage = InMemoryStorage.sharedInstance

    // Mark: Public interface

    var basket: Basket {
        return getBasket ?? Basket(items: [])
    }

    @discardableResult
    func addOrUpdate(product: Product, amount: Int) -> Bool {
        var basket = getBasket ?? Basket(items: [])
        for (index, item) in basket.items.enumerated() {
            if item.product == product {
                let newItem = BasketItem(product: item.product, amount: amount)
                basket.items.remove(at: index)
                basket.items.insert(newItem, at: index)
                storage.store(basket)
                return false
            }
        }
        basket.items += [BasketItem(product: product, amount: amount)]
        storage.store(basket)
        return true
    }

    @discardableResult
    func remove(product: Product) -> Bool {
        guard var basket = getBasket else { return false }
        let items = basket.items.filter { $0.product != product }
        basket.items = items
        storage.store(basket)
        return true
    }

    func getValue(product: Product) -> Int? {
        guard let basket = getBasket else { return nil }
        guard let item = basket.items.first(where: { $0.product == product }) else { return nil }
        return item.amount
    }

    func removeAll() {
        storage.clear(Basket.self)
    }

    func calculateBasket(currency: Currency) -> Float {
        guard let basket = getBasket else { return 0.0 }
        return basket.items.reduce(0.0, { $0 + ($1.product.price * Float($1.amount) * currency.rate) })
    }

    // MARK: Private

    fileprivate var getBasket: Basket? {
        return storage.tryRestore()
    }
}
