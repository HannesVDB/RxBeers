//
//  BeerDetailRequest.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Alamofire

struct BeerDetailRequest {
    var id: String
}

extension BeerDetailRequest: Request {

    var path: String {
        return "/beers/\(id)"
    }

    var method: HTTPMethod {
        return .get
    }
}
