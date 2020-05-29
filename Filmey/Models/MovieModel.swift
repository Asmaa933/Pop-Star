//
//  SceneDelegate.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/3/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
struct MovieModel{
    private var original_title : String
    private var poster_path : String
    private var overview : String
    private var release_date : String
    private var vote_average : Double
    private  var id : Int
    
    init(original_title : String, poster_path : String, overview : String, release_date : String, vote_average : Double, id : Int){
        self.original_title = original_title
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
        self.vote_average = vote_average
        self.id = id
    }
    func getOriginal_title() -> String{
        return original_title
    }
    
    func getPoster_path() -> String{
        return poster_path
    }
    func getOverview() -> String{
        return overview
    }
    func getRelease_date() -> String{
        return release_date
    }
    func getVote_average() -> Double{
        return vote_average
    }
    func getID() -> Int{
        return id
    }
}
