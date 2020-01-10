//
//  constants.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/4/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
let apiKey = "b535bde97adc103bbe8e5dd0aeacbe9f"
let nowPlayingURL = "https://api.themoviedb.org/3/movie/now_playing"
let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated"
let mostPopularURL = "https://api.themoviedb.org/3/movie/popular"
let minPage = 1
let nowPlayingMaxPage = 60
let topRatedMaxPage = 339
let mostPopularMaxPage = 500

enum arrays
{
    case top
    case most
    case now
}
