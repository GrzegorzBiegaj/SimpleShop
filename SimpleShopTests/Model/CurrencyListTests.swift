//
//  CurrencyListTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 26.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class CurrencyListTests: XCTestCase {

    func testCurrency() {
        let currency1 = Currency(name: "USD", rate: 1.33)
        let currency2 = Currency(name: "EUR", rate: 1.33)
        let currency3 = Currency(name: "GBP", rate: 1.33)
        let currency4 = Currency(name: "CNY", rate: 1.33)
        let currency5 = Currency(name: "DEF", rate: 2.88)

        XCTAssertEqual(currency1.symbol, "$")
        XCTAssertEqual(currency2.symbol, "€")
        XCTAssertEqual(currency3.symbol, "£")
        XCTAssertEqual(currency4.symbol, "¥")
        XCTAssertEqual(currency5.symbol, "DEF")
    }

    func testCurrencyListEquatable() {

        let currencyList1 = CurrencyList(source: "USD", quotes: ["USDEUR": 1.33, "USDCHF": 0.55])
        let currencyList2 = CurrencyList(source: "USD", quotes: ["USDEUR": 1.33, "USDCHF": 0.55])
        let currencyList3 = CurrencyList(source: "USD", quotes: ["USDEUR": 1.33, "USDCHF": 0.99])

        XCTAssertEqual(currencyList1, currencyList2)
        XCTAssertNotEqual(currencyList1, currencyList3)
    }

    func testCurrencyListListEquatable() {
        let Currency1 = Currency(name: "EUR", rate: 1.33)
        let Currency2 = Currency(name: "CHF", rate: 0.55)
        let currencyList = CurrencyList(source: "USD", quotes: ["USDEUR": 1.33, "USDCHF": 0.55])
        XCTAssertTrue(currencyList.list.contains(Currency1))
        XCTAssertTrue(currencyList.list.contains(Currency2))
    }

}
