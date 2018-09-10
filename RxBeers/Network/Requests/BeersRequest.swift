//
//  BeersRequest.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Alamofire

struct BeersRequest {

}

extension BeersRequest: Request {

    var path: String {
        return "/beers"
    }

    var method: HTTPMethod {
        return .get
    }

}
