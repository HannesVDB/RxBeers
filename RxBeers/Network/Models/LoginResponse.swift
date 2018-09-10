//
//  LoginResponse.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {

    var accessToken: String
    var refreshToken: String
    
}
