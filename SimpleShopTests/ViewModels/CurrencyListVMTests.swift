//
//  CurrencyListVMTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 28.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class CurrencyListVMTests: XCTestCase {

    func testGetDataRequestData() {

        let currencyList = CurrencyList(source: "USD", quotes: ["USDEUR": 1.34, "USDXYZ": 6.66])
        let currencyListControllerMock = CurrencyListControllerMock(currencyList: currencyList)
        let currencyListVM = CurrencyListVM(currencyListController: currencyListControllerMock)

        currencyListVM.requestData { (response) in
            switch response {
            case .success:
                var data = currencyListVM.getData(type: .full)
                XCTAssertEqual(data.count, 2)
                XCTAssertEqual(data[0].shownName, "XYZ")
                XCTAssertEqual(data[0].currency, Currency(name: "XYZ", rate: 6.66))
                XCTAssertEqual(data[1].shownName, "EUR")
                XCTAssertEqual(data[1].currency, Currency(name: "EUR", rate: 1.34))
                data = currencyListVM.getData(type: .top10)
                XCTAssertEqual(data.count, 1)
                XCTAssertEqual(data[0].shownName, "EUR")
                XCTAssertEqual(data[0].currency, Currency(name: "EUR", rate: 1.34))
            case .error(_):
                XCTFail()
            }
        }
    }

    // Info: In the final project strings will be replaced to the string keys
    func testTranslations() {

        let currencyListControllerMock = CurrencyListControllerMock()
        let currencyListVM = CurrencyListVM(currencyListController: currencyListControllerMock)

        XCTAssertEqual(currencyListVM.errorTitle, "Error")
        XCTAssertEqual(currencyListVM.errorButton, "OK")
        XCTAssertEqual(currencyListVM.errorMessage(error: ResponseError.decodeError), "Network error: decodeError")
    }

}
