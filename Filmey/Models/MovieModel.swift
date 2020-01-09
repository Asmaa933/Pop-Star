//
//  SceneDelegate.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/3/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
class MovieModel
{
    let original_title : String
	let poster_path : String
	let overview : String
	let release_date : String
	let vote_average : Double
    let id : Int

    init(original_title : String, poster_path : String, overview : String, release_date : String, vote_average : Double, id : Int)
    {
        self.original_title = original_title
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
        self.vote_average = vote_average
        self.id = id
    }
}
