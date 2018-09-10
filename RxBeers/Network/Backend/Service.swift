//
//  BeersViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireActivityLogger

class Service {
    
    // MARK: - Init
    
    static let shared = Service()
    
    private init() {
    }
    
    // MARK: - Manager
    
    private lazy var sessionManager: SessionManager = { [unowned self] in
        let manager = SessionManager()
        manager.adapter = Adapter()
        return manager
        }()
    
    // MARK: - Execute
    
    func execute(_ request: Request, with serializer: Serializer, completion: (() -> Void)? = nil) {
        sessionManager
            .request(request)
            .validate()
            .log(level: .info)
            .responseData { response in
                serializer.serialize(response.data)
                completion?()
        }
    }
    
}
