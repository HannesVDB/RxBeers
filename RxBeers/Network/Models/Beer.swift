//
//  Beer.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation

struct Beer: Codable {

    var id: String
    var name: String
    var rating: Int
    var thumbImageUrl: String
    var imageUrl: String
    var brewery: Brewery
    

}
