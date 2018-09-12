//
//  LoginViewModelSpec.swift
//  RxBeersTests
//
//  Created by Hannes Van den Berghe on 12/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Quick
import Nimble

@testable import RxBeers

class LoginViewModelSpec: QuickSpec {

    override func spec() {

        describe("LoginViewModel") {
            var sut: LoginViewModel!

            beforeEach {
                sut = LoginViewModel()
            }

            it("Should initialize") {
                expect(sut).notTo(beNil())
            }
        }

    }

}
