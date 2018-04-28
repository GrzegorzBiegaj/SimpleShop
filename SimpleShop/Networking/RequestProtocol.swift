//
//  RequestProtocol.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 23.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var successStatusCode: Int { get }
    var httpMethod: HTTPMethod { get }
    var endpoint: String { get }
    var requestParameters: RequestParameters { get }

    associatedtype InterpreterType: InterpreterProtocol
    var interpreter: InterpreterType { get }
}

extension RequestProtocol {
    var successStatusCode: Int { return 200 }
    var httpMethod: HTTPMethod { return .get }
    var requestParameters: RequestParameters { return nil }
}
