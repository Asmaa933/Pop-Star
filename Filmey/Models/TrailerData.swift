//
//  TrailerData.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/6/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation

struct TrailerData{
   private var name : String
   private var key : String
   private var site : String
   private var type : String
    
    init(name : String, key : String, site : String, type : String)
    {
        self.name = name
         self.key = key
         self.site = site
         self.type = type
    }
    func getName() -> String{
        return name
    }
    func getKey() -> String{
           return key
       }
    func getSite() -> String{
           return site
       }
    func getType() -> String{
           return type
       }
}
