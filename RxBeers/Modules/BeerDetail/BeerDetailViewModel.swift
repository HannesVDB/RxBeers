//
//  BeerDetailViewModel.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BeerDetailViewModelInput {
    var beer: Beer
}

struct BeerDetailViewModel: InOutViewModel {

    var `in`: BeerDetailViewModel.In
    var out: BeerDetailViewModel.Out

    init(input: BeerDetailViewModelInput) {

        let imageUrl = URL(string: input.beer.imageUrl)



        self.in = In()
        self.out = Out(screenName: Observable.just(input.beer.name),
                       beerTitle: Observable.just(input.beer.name),
                       description: Observable.just(input.beer.brewery.name),
                       imageUrl: Observable.just(imageUrl))

    }
}

extension BeerDetailViewModel {

    struct In {

    }

    struct Out {

        let screenName: Observable<String>
        let beerTitle: Observable<String>
        let description: Observable<String>
        let imageUrl: Observable<URL?>
        
    }

}
