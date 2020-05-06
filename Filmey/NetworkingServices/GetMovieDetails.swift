//
//  GetMovieByID.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/9/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class GetMovieDetails
{
    static func getMovieById(movieID: Int,completion: @escaping (_ jsonData: MovieModel?,_ error:Error?) -> Void)
    {
        var movieDetails : MovieModel?
        let url = "https://api.themoviedb.org/3/movie/\(movieID)"
        let parameters = ["api_key": apiKey , "language" : "en-US"]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseJSON{(response) in
            switch response.result{
            case .success:
                guard let data = response.data else {return}
                do{
                    let json = try JSON(data: data)
                    let original_title = json["original_title"].stringValue
                    let poster_path = json["poster_path"].stringValue
                    let overview = json["overview"].stringValue
                    let release_date = json["release_date"].stringValue
                    let vote_average = json["vote_average"].doubleValue
                    
                    if (original_title != "" && poster_path != "" && overview != "" && release_date != "" && vote_average != 0)
                    {
                        movieDetails = MovieModel(original_title: original_title, poster_path: poster_path, overview: overview, release_date: release_date, vote_average: vote_average, id: movieID)
                        
                    }
                    completion(movieDetails,nil)
                }catch(let error){
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                completion(nil,error)
                print(error.localizedDescription)
                
            }
        }
    }
}
