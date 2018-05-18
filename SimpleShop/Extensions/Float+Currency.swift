//
//  Float+Currency.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 18.05.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

extension Float {

    func currency(code: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = code
        currencyFormatter.locale = Locale.current
        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
        return currencyFormatter.string(for: self) ?? "--"
    }
}
