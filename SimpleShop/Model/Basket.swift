//
//  Basket.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct BasketItem: Equatable {
    let product: Product
    let amount: Int
}

struct Basket {
    var items: [BasketItem]
}

extension BasketItem {

    func getPriceTotalString(currency: Currency) -> String {
        let totalPrice = product.price * Float(amount) * currency.rate
        return totalPrice.currency(code: currency.name)
    }
}

extension Basket: InMemoryStorable { }
