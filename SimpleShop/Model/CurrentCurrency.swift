//
//  CurrentCurrency.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct CurrentCurrency {
    let currency: Currency
}

extension CurrentCurrency: InMemoryStorable { }
