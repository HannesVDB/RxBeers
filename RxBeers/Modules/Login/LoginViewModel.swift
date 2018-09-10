//
//  LoginViewModel.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel: InOutViewModel {

    var `in`: LoginViewModel.In
    var out: LoginViewModel.Out

    private var username: String?
    private var password: String?

    private let disposeBag = DisposeBag()
    private let loginTappedSubject = PublishSubject<Void>()
    private let usernameSubject = PublishSubject<String?>()
    private let passwordSubject = PublishSubject<String?>()
    private let successSubject = PublishSubject<Bool>()

    init() {

        self.in = In(loginTapped: loginTappedSubject.asObserver(),
                     username: usernameSubject.asObserver(),
                     password: passwordSubject.asObserver())

        self.out = Out(success: successSubject.asObservable())


        let result = loginTappedSubject.flatMap { _ -> Observable<LoginResponse?> in
            guard let username = self.username, let password = self.password else {
                return Observable.just(nil)
            }

            return Observable.create { observer in
                let request = LoginRequest(username: username, password: password, deviceId: NSUUID().uuidString)
                let serializer = JSONSerializer<LoginResponse>()

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
        }

        usernameSubject
            .asObservable()
            .subscribe(onNext: { input in
                self.username = input
            })
            .disposed(by: disposeBag)

        passwordSubject
            .asObservable()
            .subscribe(onNext: { input in
                self.password = input
            })
            .disposed(by: disposeBag)
        

        result
            .subscribe(onNext: { value in
                guard let value = value else {
                    return
                }
                print(value)
                // TODO: Out for navigation
                self.successSubject.onNext(true)
            }, onError: { error in
                // TODO: On error should do something
                print("Error \(error.localizedDescription)")
                self.successSubject.onNext(false)
            })
            .disposed(by: disposeBag)
        
    }
    
}

extension LoginViewModel {

    struct In {

        let loginTapped: AnyObserver<Void>
        let username: AnyObserver<String?>
        let password: AnyObserver<String?>

    }

    struct Out {
        let success: Observable<Bool>
    }

}
