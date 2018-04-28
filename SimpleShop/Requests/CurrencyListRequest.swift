//
//  CurrencyListRequest.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct CurrencyListRequest: RequestProtocol {

    let key: String

    // MARK: Request protocol

    var endpoint: String { return "http://www.apilayer.net/api/live" }

    var requestParameters: RequestParameters {
        return ["access_key": key]
    }

    let interpreter: CurrencyListInterpreter = CurrencyListInterpreter()
}
