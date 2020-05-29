//
//  moviesCell.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/4/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import SDWebImage

class moviesCell: UICollectionViewCell{
    @IBOutlet weak private var movieImg: UIImageView!
    
    func configureCell(poster_path : String){
        layer.backgroundColor = UIColor.clear.cgColor
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true;

        layer.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        layer.shadowOffset = CGSize(width:0,height: 2.0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false;
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        movieImg.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(poster_path)"), placeholderImage: UIImage(named: "popcorn"),completed: nil)
    }
   
}

