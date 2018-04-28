//
//  ConstantsControllerMock.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 27.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleShop

class ConstantsControllerMock: ConstantsControllerProtocol {

    var jsonratesKey: String
    var defaultCurrency: String
    var maxProductAmount: Int

    init(jsonratesKey: String = "", defaultCurrency: String = "", MaxProductAmount: Int = 10) {
        self.jsonratesKey = jsonratesKey
        self.defaultCurrency = defaultCurrency
        self.maxProductAmount = MaxProductAmount
    }

}
