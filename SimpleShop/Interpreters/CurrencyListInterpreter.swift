//
//  CurrencyListInterpreter.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 23.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

class CurrencyListInterpreter: InterpreterProtocol {

    // Mark: Public interface
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?, successStatusCode: Int) -> Response<CurrencyList, ResponseError> {

        if let _ = error { return Response.error(ResponseError.connectionError) }
        guard response?.statusCode == successStatusCode else {
            return Response.error(ResponseError.invalidResponseError)
        }

        guard let data = data else { return Response.error(ResponseError.invalidResponseError) }
        guard let response = try? JSONDecoder().decode(CurrencyList.self, from: data) else {
            return Response.error(ResponseError.decodeError)
        }
        return Response.success(response)
    }
}
