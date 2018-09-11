//
//  BeerDetailViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage
import RxOptional

class BeerDetailViewController: UIViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTitleLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!

    var viewModel: BeerDetailViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        viewModel
            .out
            .screenName
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)

        viewModel
            .out
            .beerTitle
            .bind(to: beerTitleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel
            .out
            .description
            .bind(to: beerDescriptionLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel
            .out
            .imageUrl
            .filterNil()
            .subscribe(onNext: { url in
                self.beerImageView.sd_setImage(with: url, completed: nil)
            })
            .disposed(by: disposeBag)
    }

}

extension BeerDetailViewController {
    
    class func build(with input: BeerDetailViewModelInput) -> BeerDetailViewController {
        let storyboard = UIStoryboard(name: "BeerDetail", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! BeerDetailViewController //swiftlint:disable:this force_cast
        viewController.viewModel = BeerDetailViewModel(input: input)

        return viewController
    }
}
