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

    init() {

        self.in = In()
        self.out = Out(beers: beersSubject.asObserver())

        Observable
            .create { observer in
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
            .subscribe(beersSubject)
            .disposed(by: disposeBag)
    }
    
}

extension BeersViewModel {

    struct In {

    }

    struct Out {
        let beers: Observable<[Beer]>
    }

}
