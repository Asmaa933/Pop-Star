//
//  favoriteCell.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/6/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import SDWebImage

class favoriteCell: UITableViewCell{
    @IBOutlet weak private var movieImg: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var releaseLabel: UILabel!
    @IBOutlet weak private var rateLabel: UILabel!
    
    func configureCell(imageURL: String, title: String, release: String, rate: String) {
        movieImg.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "popcorn"),completed: nil)
        titleLabel.text = title
        releaseLabel.text = release
        rateLabel.text = rate
    }
}
