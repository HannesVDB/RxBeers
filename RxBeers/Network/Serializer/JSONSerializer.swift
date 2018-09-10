//
//  BeersViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation

class JSONSerializer<T: Codable>: Serializer {
    
    private var result: Result<T>?
    private var error: BackendError?
    
    func serialize(_ data: Data?) {
        guard let data = data else {
            self.error = BackendError()
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        do {
            self.result = try decoder.decode(Result.self, from: data)
        } catch {
            print(error)
            self.error = BackendError()
        }
    }
    
    var response: Response<Result<T>> {
        if let result = result {
            return .success(result)
        } else if let error = error {
            return .failure(error)
        } else {
            return .failure(BackendError())
        }
    }
    
}
