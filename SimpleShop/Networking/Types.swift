//
//  Types.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 23.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

typealias RequestParameters = [String: Any]?

enum Response<T, E: Error> {
    case success(T)
    case error(E)
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}

enum ResponseError: Error {
    case connectionError
    case invalidResponseError
    case decodeError
    case unknownError

    var errorDescription: String {
        switch self {
        case .connectionError: return "Connection error"
        case .invalidResponseError: return "Invalid response Error"
        case .decodeError: return "Data decode error"
        case .unknownError: return "Unknown error"
        }
    }
}
