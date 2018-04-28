//
//  CurrencyListControllerMock.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleShop

class CurrencyListControllerMock: CurrencyListControllerProtocol {

    let currencyList: CurrencyList?
    let responseError: ResponseError?

    init (currencyList: CurrencyList? = nil, responseError: ResponseError? = nil) {
        self.currencyList = currencyList
        self.responseError = responseError
    }

    func currencyList(handler: @escaping (Response<CurrencyList, ResponseError>) -> ()) {

        if let currencyList = currencyList {
            handler(.success(currencyList))
        }

        if let responseError = responseError {
            handler(.error(responseError))
        }

    }


}
