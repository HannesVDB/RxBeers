//
//  BeerDetailViewModelSpec.swift
//  RxBeersTests
//
//  Created by Hannes Van den Berghe on 12/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
import RxTest

@testable import RxBeers

class BeerDetailViewModelSpec: QuickSpec {

    override func spec() {

        describe("BeerDetailViewModel") {
            var sut: BeerDetailViewModel!

            let brewery = Brewery(id: "1", name: "AbInbev", address: "address", city: "city", country: "country")
            let beer = Beer(id: "1", name: "Jupiler", rating: 10, thumbImageUrl: "url", imageUrl: "url2", brewery: brewery)
            let input = BeerDetailViewModelInput(beer: beer)

            let disposeBag = DisposeBag()

            beforeEach {
                sut = BeerDetailViewModel(input: input)
            }

            it("Should not be nil") {
                expect(sut).notTo(beNil())
            }

            context("Output") {

                it("Should have the correct screenname") {
                    sut.out.screenName.subscribe(onNext: { name in
                        expect(name) == "Jupiler"
                    }).disposed(by: disposeBag)
                }

                it("Should have the correct beer title") {
                    sut.out.beerTitle.subscribe(onNext: { title in
                        expect(title) == "Jupiler"
                    }).disposed(by: disposeBag)
                }

                it("Should have the correct description") {
                    sut.out.description.subscribe(onNext: { description in
                        expect(description) == "AbInbev"
                    }).disposed(by: disposeBag)
                }

                it("Should have the correct imageUrl") {
                    sut.out.imageUrl.subscribe(onNext: { url in
                        expect(url).notTo(beNil())
                    }).disposed(by: disposeBag)
                }

                it("Other test") {
                    let result = try! sut.out.beerTitle.toBlocking().first()
                    expect(result).notTo(beNil())
                    expect(result) == "Jupiler"
                }
            }

        }
    }

}
