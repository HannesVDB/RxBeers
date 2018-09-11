//
//  BeersViewModel.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BeersViewModel: InOutViewModel {

    var `in`: BeersViewModel.In
    var out: BeersViewModel.Out

    private let disposeBag = DisposeBag()
    private let beersSubject = BehaviorSubject<[Beer]>(value: [])
    private let selectedIndexPathSubject = PublishSubject<IndexPath>()
    private let selectedBeerSubject = PublishSubject<Beer>()

    init() {

        self.in = In(selectedIndexPath: selectedIndexPathSubject.asObserver())
        self.out = Out(beers: beersSubject.asObservable(), selectedBeer: selectedBeerSubject.asObservable())

        let beers: Observable<[Beer]> = Observable.create { observer in
                let request = BeersRequest()
                let serializer = JSONSerializer<[Beer]>()

                Service.shared.execute(request, with: serializer, completion: {
                    switch serializer.response {
                    case .success(let result):
                        observer.onNext(result.data)
                    case .failure(let error):
                        observer.onError(error)
                    }
                })

                return Disposables.create()
            }

        beers
            .subscribe(beersSubject)
            .disposed(by: disposeBag)

        Observable
            .combineLatest(beers, selectedIndexPathSubject.asObservable())
            .map { someBeers, indexPath in
                return someBeers[indexPath.row]
            }
            .subscribe(selectedBeerSubject)
            .disposed(by: disposeBag)
    }
    
}

extension BeersViewModel {

    struct In {
        let selectedIndexPath: AnyObserver<IndexPath>
    }

    struct Out {
        let beers: Observable<[Beer]>
        let selectedBeer: Observable<Beer>
    }

}
