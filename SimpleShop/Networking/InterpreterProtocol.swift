//
//  InterpreterProtocol.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 23.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol InterpreterProtocol {
    associatedtype SuccessType
    associatedtype ErrorType: Error

    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?, successStatusCode: Int) -> Response<SuccessType, ErrorType>
}
