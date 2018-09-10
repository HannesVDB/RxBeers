//
//  BeersViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation

struct Result<T: Codable>: Codable {
    
    struct Metadata: Codable {
        var count: Int?
        var totalCount: Int?
    }
    
    var meta: Metadata?
    var data: T
    
}
