//
//  NetworkingMock.swift
//  SimpleShopTests
//
//  Created by Grzegorz Biegaj on 26.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleShop

class NetworkingMock: RequestConnectionProtocol {

    var data: Data?
    var error: Error?
    var response: HTTPURLResponse?

    init (data: Data? = nil, error: Error? = nil, response: HTTPURLResponse? = nil) {
        self.data = data
        self.error = error
        self.response = response
    }

    func performRequest<Req: RequestProtocol>(request: Req, handler: @escaping (Response<Req.InterpreterType.SuccessType, Req.InterpreterType.ErrorType>) -> Void) {

        let res = request.interpreter.interpret(data: data, response: response, error: error, successStatusCode: request.successStatusCode)
        handler(res)
    }
}
