//
//  BeersViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation
import Alamofire

class Adapter: RequestAdapter {

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        // Add default headers to project.
    
        urlRequest.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2Y2QzNmZmZS00M2NlLTExZTgtODQ2YS0wYjllZWNlOTZkNWEiLCJpYXQiOjE1MzY1Njc3MTQsImF1ZCI6IlNJTFZFUkJBQ0siLCJpc3MiOiJzaWx2ZXJiYWNrIn0.um3qDYf-7wrkR8-dNK0vwrQD7gNENj6ZebsqKKMkvJ8", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
}
