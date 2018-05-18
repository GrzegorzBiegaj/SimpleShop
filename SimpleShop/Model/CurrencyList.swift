//
//  CurrencyList.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 23.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct Currency: Equatable {
    let name: String
    let rate: Float
}

struct CurrencyList: Codable, Equatable {
    let source: String
    let quotes: [String: Float]
}

extension CurrencyList {
    var list: [Currency] {
        return quotes.map { Currency(name: String($0.key.dropFirst(source.count)), rate: $0.value) }
    }

}
