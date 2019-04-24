//
//  RequestConnection.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 23.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol RequestConnectionProtocol {

    func performRequest<Req: RequestProtocol>(request: Req, handler: @escaping (Result<Req.InterpreterType.SuccessType, Req.InterpreterType.ErrorType>) -> Void)
}

class RequestConnection: RequestConnectionProtocol {

    // MARK: Configuration
    let connectionTimeout = 15.0

    // Mark: Public interface

    func performRequest<Req: RequestProtocol>(request: Req, handler: @escaping (Result<Req.InterpreterType.SuccessType, Req.InterpreterType.ErrorType>) -> Void) {

        guard let url = computeURL(request) else { return }
        guard let urlRequest = setupURLRequest(request, url: url) else { return }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, res, error in

            let response = request.interpreter.interpret(data: data, response: res as? HTTPURLResponse, error: error, successStatusCode: request.successStatusCode)

            self.connectionLog(request, value: "Request")
            DispatchQueue.main.async {
                handler(response)
            }
        }
        task.resume()
    }

    // MARK: private methods

    private func setupURLRequest<Req: RequestProtocol>(_ request: Req, url: URL) -> URLRequest? {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.timeoutInterval = connectionTimeout
        return urlRequest
    }

    private func computeURL<Req: RequestProtocol>(_ request: Req) -> URL? {

        var urlComponents = URLComponents(string: request.endpoint)
        urlComponents?.queryItems = request.requestParameters?.map { return URLQueryItem(name: $0.key, value: "\($0.value)")}
        return urlComponents?.url
    }

    fileprivate func connectionLog<Req: RequestProtocol>(_ request: Req, value: String) {

        let splitted = request.endpoint.components(separatedBy: "/")
        if let normalizedEndpoint = splitted.count > 0 ? splitted.last : request.endpoint {
            print("Backend connection: \(normalizedEndpoint) - \(value)")
            print (request.endpoint)
        }
    }
}
