//
//  CurrencyListControllerTests.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 27.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleShop

class CurrencyListControllerTests: XCTestCase {
    
    func testPositiveResponse() {

        var data: Data?
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let currencyList = CurrencyList(source: "USD", quotes: ["USDUSD": 1.0, "USDEUR": 0.8, "USDCHF": 0.79])
        do {
            data = try JSONEncoder().encode(currencyList)
        }
        catch {
            XCTFail()
        }

        let mockNetworking = NetworkingMock(data: data, error: nil, response: response)
        let mockConstant = ConstantsControllerMock()
        let currencyListController = CurrencyListController(connection: mockNetworking, constantsController: mockConstant)

        currencyListController.currencyList { (response) in
            switch response {
            case .success(let responseData):
                XCTAssertEqual(responseData, currencyList)
            case .failure(_):
                XCTFail()
            }
        }

    }

    func testNegativeResponse() {

        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let mockNetworking = NetworkingMock(data: nil, error: nil, response: response)
        let mockConstant = ConstantsControllerMock()
        let currencyListController = CurrencyListController(connection: mockNetworking, constantsController: mockConstant)

        currencyListController.currencyList { (response) in
            switch response {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, ResponseError.invalidResponseError)
            }
        }
    }

    func testNegativeError() {

        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockNetworking = NetworkingMock(data: nil, error: ResponseError.connectionError, response: response)
        let mockConstant = ConstantsControllerMock()
        let currencyListController = CurrencyListController(connection: mockNetworking, constantsController: mockConstant)

        currencyListController.currencyList { (response) in
            switch response {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, ResponseError.connectionError)
            }
        }
    }

}
