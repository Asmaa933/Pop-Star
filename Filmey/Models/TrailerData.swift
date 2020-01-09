//
//  TrailerData.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/6/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
class TrailerData
{
    var name : String
    var key : String
    var site : String
    var type : String
    
    init(name : String, key : String, site : String, type : String)
    {
        self.name = name
         self.key = key
         self.site = site
         self.type = type
    }
}
