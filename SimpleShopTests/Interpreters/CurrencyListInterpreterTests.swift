//
//  CurrencyListInterpreterTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 26.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class CurrencyListInterpreterTests: XCTestCase {
    
    func testCurrencyListInterpreterValidData() {

        var data: Data?
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let successStatusCode = 200

        let currencyList = CurrencyList(source: "USD", quotes: ["USDUSD": 1.0, "USDEUR": 0.8, "USDCHF": 0.79])

        do {
            data = try JSONEncoder().encode(currencyList)
        }
        catch {
            XCTFail()
        }

        let currencyListInterpreter = CurrencyListInterpreter()
        let resp = currencyListInterpreter.interpret(data: data, response: response, error: nil, successStatusCode: successStatusCode)
        switch resp {
        case .success(let data):
            XCTAssertEqual(data, currencyList)
        case .error(_):
            XCTFail()
        }
    }

    func testCurrencyListInterpreterInvalidResponse() {

        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let successStatusCode = 400
        let currencyListInterpreter = CurrencyListInterpreter()
        let resp = currencyListInterpreter.interpret(data: nil, response: response, error: nil, successStatusCode: successStatusCode)
        switch resp {
        case .success(_):
            XCTFail()
        case .error(let responseError):
            XCTAssertEqual(responseError, ResponseError.invalidResponseError)
        }
    }

    func testCurrencyListInterpreterError() {

        let response = HTTPURLResponse()
        let error = NSError(domain: "test", code: 100, userInfo: nil)
        let successStatusCode = 400

        let currencyListInterpreter = CurrencyListInterpreter()
        let resp = currencyListInterpreter.interpret(data: nil, response: response, error: error, successStatusCode: successStatusCode)
        switch resp {
        case .success(_):
            XCTFail()
        case .error(let responseError):
            XCTAssertEqual(responseError, ResponseError.connectionError)
        }
    }
    
}
