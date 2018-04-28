//
//  Products.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

class Products {

    // Product list - in the futute it can be downloaded from the backend

    let products = [
        Product(name: "Peas", description: "Fresh green pease", quantity: "1 kg", packageType: .bag, price: 0.95, imageName: "peas"),
        Product(name: "Eggs", description: "Fresh bio eggs", quantity: "12 pieces", packageType: .dozen, price: 2.10, imageName: "eggs"),
        Product(name: "Milk", description: "Fresh good milk", quantity: "1 l", packageType: .bottle, price: 1.30, imageName: "milk"),
        Product(name: "Beans", description: "Fresh good Beans", quantity: "1 kg", packageType: .can, price: 0.73, imageName: "beans")
    ]
}
