//
//  BeersViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation

struct BackendError: LocalizedError {
    
    var localizedDescription: String {
        return "💣 General backend error"
    }
    
    init() {
    }
    
}
