//
//  CurrencyListController.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol CurrencyListControllerProtocol {

    func currencyList(handler: @escaping (Response<CurrencyList, ResponseError>) -> ())
    
}

class CurrencyListController: CurrencyListControllerProtocol {

    fileprivate let connection: RequestConnectionProtocol
    fileprivate let constantsController: ConstantsControllerProtocol

    // Mark: Public interface
    
    init (connection: RequestConnectionProtocol = RequestConnection(), constantsController: ConstantsControllerProtocol = ConstantsController()) {
        self.connection = connection
        self.constantsController = constantsController
    }

    func currencyList(handler: @escaping (Response<CurrencyList, ResponseError>) -> ()) {

        let request = CurrencyListRequest(key: constantsController.jsonratesKey)
        connection.performRequest(request: request) { (response) in

            switch response {
            case .success(let currencyList):
                handler(.success(currencyList))
            case .error(let error):
                handler(.error(error))
            }
        }
    }
}
