//
//  CurrencyListRequestTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 26.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class CurrencyListRequestTests: XCTestCase {
    
    func testCurrencyListRequest() {

        let key = "Test123"
        let currencyListRequest = CurrencyListRequest(key: key)

        XCTAssertEqual(currencyListRequest.successStatusCode, 200)
        XCTAssertEqual(currencyListRequest.httpMethod, .get)
        XCTAssertEqual(currencyListRequest.endpoint, "http://www.apilayer.net/api/live")
        XCTAssertEqual(currencyListRequest.requestParameters?["access_key"] as? String, key)
    }

}
