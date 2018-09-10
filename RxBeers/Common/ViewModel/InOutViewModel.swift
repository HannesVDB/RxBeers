//
//  InOutViewModel.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation

protocol InOutViewModel: ViewModel {

    // swiftlint:disable type_name
    associatedtype In
    associatedtype Out

    var `in`: In { get }
    var out: Out { get }
}
