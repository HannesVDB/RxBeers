//
//  BeerTableViewCell.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import UIKit
import SDWebImage

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func setBeer(beer: Beer) {
        beerLabel.text = beer.name
        descriptionLabel.text = beer.brewery.name

        beerImageView.sd_setImage(with: URL(string: beer.thumbImageUrl), completed: nil)
    }
    
}
