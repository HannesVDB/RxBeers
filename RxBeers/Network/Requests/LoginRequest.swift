//
//  LoginRequest.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Alamofire

struct LoginRequest {

    var username: String
    var password: String
    var deviceId: String

}

extension LoginRequest: Request {

    var path: String {
        return "/auth/login"
    }

    var method: HTTPMethod {
        return .post
    }

    var body: [String : Any]? {
        return [
            "username": username,
            "password": password,
            "deviceId": deviceId
        ]
    }
}
