//
//  CurrencyListVM.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct ShowCurrency {
    let shownName: String
    let currency: Currency
}

enum CurrencyListType {
    case top10
    case full
}

class CurrencyListVM {

    enum CurrencyListResponse {
        case success
        case error(ResponseError)
    }

    let currencyListController: CurrencyListControllerProtocol

    init(currencyListController: CurrencyListControllerProtocol = CurrencyListController()) {
        self.currencyListController = currencyListController
    }

    fileprivate var currency: [Currency] = []

    func getData(type: CurrencyListType) -> [ShowCurrency] {
        return mapToShowCurrency(currencyList: currency, type: type)
    }

    func requestData(closure: @escaping (CurrencyListResponse) -> ()) {

        currencyListController.currencyList { (response) in
            switch response {
            case .success(let currencyList):
                self.currency = currencyList.list
                closure(CurrencyListResponse.success)
            case .error(let error):
                closure(CurrencyListResponse.error(error))
            }
        }
    }

    // Translations
    let errorTitle = "Error"
    let errorButton = "OK"

    func errorMessage(error: Error) -> String {
        return "Network error: \(error)"
    }
    
    // MARK: Privat

    // Top 10 currencies
    fileprivate let arrayToFiler = ["USD", "EUR", "JPY", "GBP", "CHF", "CAD", "AUD", "NZD", "ZAD", "CNY"]

    func mapToShowCurrency(currencyList: [Currency], type: CurrencyListType) -> [ShowCurrency] {
        var filteredMap = currencyList
        if case .top10 = type {
            filteredMap = currencyList.filter { arrayToFiler.contains($0.name) }
        }
        return filteredMap.map { ShowCurrency(shownName: "\($0.name) \(String(describing: $0.name != $0.symbol ? "(" + $0.symbol + ")" : ""))" ,currency: $0) }
    }
}
