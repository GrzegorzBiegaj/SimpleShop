//
//  Product.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

enum PackageType: String {
    case bag = "bag"
    case dozen = "dozen"
    case bottle = "bottle"
    case can = "can"

    var getDescription: String {
        return "Package type: " + self.rawValue
    }
}

struct Product: Equatable {
    let identifier: String
    let name: String
    let description: String
    let quantity: String
    let packageType: PackageType
    let price: Float
    let imageName: String?

    init (name: String, description: String, quantity: String, packageType: PackageType, price: Float, imageName: String? = nil) {
        self.identifier = UUID().uuidString
        self.name = name
        self.description = description
        self.quantity = quantity
        self.packageType = packageType
        self.price = price
        self.imageName = imageName
    }
}

extension Product {

    func getPriceString(currency: Currency) -> String {
        let str = NSString(format: "%.2f %@", price * currency.rate, currency.symbol)
        return String(str)
    }
}
