//
//  ReviewCell.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/11/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    @IBOutlet weak private var autherLabel: UILabel!
    
    @IBOutlet weak private var reviewText: UITextView!
    
    func configureCell(auther: String, review: String) {
        autherLabel.text = auther
        reviewText.text = review
    }

}
