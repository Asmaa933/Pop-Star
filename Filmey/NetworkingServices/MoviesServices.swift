//
//  NowPlayingServices.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/4/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MoviesServices
{
    static private(set) var nowPlayingArr = [MovieModel]()
    static private(set) var topRatedArr = [MovieModel]()
    static private(set) var mostPopularArr = [MovieModel]()    
    static func resetArray(arr: arrays)
    {
        switch arr
        {
        case .top:
            MoviesServices.topRatedArr.removeAll()
        case .most:
            MoviesServices.mostPopularArr.removeAll()
        case .now:
            MoviesServices.nowPlayingArr.removeAll()
        }
    }
    class  func getMovies(pageNum: Int, array: arrays,completion: @escaping (_ jsonData: [MovieModel]?,_ error:Error?) -> Void)
    {
        var url = ""
        switch array
        {
        case .now:
            url = nowPlayingURL
        case .top:
            url = topRatedURL
        case .most:
            url = mostPopularURL
        }
        if Reachability.isConnectedToNetwork()
        {
            let parameters : [String:Any] = ["api_key": apiKey , "language" : "en-US","page" : pageNum]
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseJSON{(response) in
                switch response.result{
                case .success:
                    guard let data = response.data else {return}
                    do
                    {
                        let json = try JSON(data: data)
                        let result = json["results"]
                        for item in 0..<result.count
                        {
                            let dic = result[item]
                            let original_title = dic["original_title"].stringValue
                            let poster_path = dic["poster_path"].stringValue
                            let overview = dic["overview"].stringValue
                            let release_date = dic["release_date"].stringValue
                            let vote_average = dic["vote_average"].doubleValue
                            let id = dic["id"].intValue
                            if (original_title != "" && poster_path != "" && overview != "" && release_date != "" && vote_average != 0 && id != 0)
                            {
                                switch array
                                {
                                    
                                case .now:
                                    MoviesServices.nowPlayingArr.append(MovieModel(original_title: original_title, poster_path: poster_path, overview: overview, release_date: release_date, vote_average: vote_average, id: id))
                                    completion(MoviesServices.nowPlayingArr,nil)
                                    
                                case .top:
                                    MoviesServices.topRatedArr.append(MovieModel(original_title: original_title, poster_path: poster_path, overview: overview, release_date: release_date, vote_average: vote_average, id: id))
                                    completion(MoviesServices.topRatedArr,nil)
                                    
                                    
                                case .most:
                                    MoviesServices.mostPopularArr.append(MovieModel(original_title: original_title, poster_path: poster_path, overview: overview, release_date: release_date, vote_average: vote_average, id: id))
                                    completion(MoviesServices.mostPopularArr,nil)
                                    
                                }
                            }
                        }
                    }
                    catch(let error){
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    completion(nil,error)
                    print(error.localizedDescription)
                    
                }
            }
        }
        
    }
    
}

