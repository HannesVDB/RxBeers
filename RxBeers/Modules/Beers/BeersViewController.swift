//
//  BeersViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import UIKit
import RxSwift
import Stella

class BeersViewController: UIViewController {

    var viewModel: BeersViewModel!

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beers"
        setupTableView()

        viewModel
            .out
            .selectedBeer
            .asObservable().subscribe(onNext: { beer in
                let input = BeerDetailViewModelInput(beer: beer)
                let controller = BeerDetailViewController.build(with: input)
                self.navigationController?.show(controller, sender: self)
            })
            .disposed(by: disposeBag)
    }
    
}

extension BeersViewController {

    private func setupTableView() {
        tableView.register(class: BeerTableViewCell.self)
        tableView.rowHeight = 200

        viewModel
            .out
            .beers
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: BeerTableViewCell.reuseIdentifier, cellType: BeerTableViewCell.self)) { row, beer, cell in
                cell.setBeer(beer: beer)
            }
            .disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .subscribe(viewModel.in.selectedIndexPath)
            .disposed(by: disposeBag)
    }

}

extension BeersViewController {

    class func build() -> BeersViewController {
        let storyboard = UIStoryboard(name: "Beers", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! BeersViewController
        viewController.viewModel = BeersViewModel()

        return viewController
    }
    
}
