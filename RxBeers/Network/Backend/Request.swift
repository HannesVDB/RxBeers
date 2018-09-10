//
//  BeersViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation
import Alamofire

protocol Request: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    
    var query: [String: Any]? { get }
    var body: [String: Any]? { get }
}

/// URLRequestConvertible

extension Request {
    
    private var baseURL: URL {
        return URL(string: "https://icapps-nodejs-beers-api.herokuapp.com/api/v1")!
    }
    
    private func httpBody() throws -> Data? {
        guard let body = body else { return nil }
        return try JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = try URLRequest(url: url, method: method)
        urlRequest.httpBody = try httpBody()
        return try URLEncoding.queryString.encode(urlRequest, with: query)
    }
    
}

/// DEFAULT IMPLEMTATIONS

extension Request {
    var query: [String: Any]? {
        return nil
    }
    
    var body: [String: Any]? {
        return nil
    }
}
