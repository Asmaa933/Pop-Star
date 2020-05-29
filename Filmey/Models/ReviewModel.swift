//
//  ReviewModel.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/11/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
struct ReviewModel{
    private var author : String
    private var content : String
    private var total_pages : Int
    
    init(author : String,content : String, total_pages : Int) {
        self.author = author
        self.content = content
        self.total_pages = total_pages
    }
    func getAuther() -> String {
        return author
    }
    func getContent() -> String {
        return content
    }
    func getTotalPage() -> Int {
        return total_pages
    }
    
}
