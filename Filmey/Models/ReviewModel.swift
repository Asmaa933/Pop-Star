//
//  ReviewModel.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/11/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
class ReviewModel
{
    var author : String
    var content : String
    var total_pages : Int
    init(author : String,content : String, total_pages : Int) {
        self.author = author
        self.content = content
        self.total_pages = total_pages
    }
    
}
