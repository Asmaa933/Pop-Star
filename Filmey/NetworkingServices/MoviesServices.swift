//
//  NowPlayingServices.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/4/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
class MoviesServices
{
    static private(set) var nowPlayingArr = [MovieModel]()
    static private(set) var topRatedArr = [MovieModel]()
    static private(set) var mostPopularArr = [MovieModel]()
    let serialQueue = DispatchQueue(label: "myqueue")
    
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
    func nowPlayingData(pageNum: Int, completion: @escaping (_ jsonData: [MovieModel],_ error:Error?) -> Void)
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(pageNum)"
        )
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, respose, error) in
            do
            {
                let json  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                guard let result = json["results"] as? [[String:Any]] else {return}
                for i in 0..<result.count
                {
                    let dic = result[i]
                    let original_title = dic["original_title"] as? String ?? ""
                    let poster_path = dic["poster_path"] as? String ?? ""
                    let overview = dic["overview"] as? String ?? ""
                    let release_date = dic["release_date"] as? String ?? ""
                    let vote_average = dic["vote_average"] as? Double ?? 0
                    let id = dic["id"] as? Int ?? 0
                    if (original_title != "" && poster_path != "" && overview != "" && release_date != "" && vote_average != 0 && id != 0)
                    {
                        self.serialQueue.sync {
                            MoviesServices.nowPlayingArr.append(MovieModel(original_title:original_title , poster_path: poster_path, overview: overview, release_date: release_date, vote_average: vote_average, id: id))
                        }
                    }
                }
                completion(MoviesServices.nowPlayingArr,nil)
            }
                
            catch
            {
                print("error")
            }
        }
        task.resume()
    }
    
    func topRatedData(pageNum: Int,completion: @escaping (_ jsonData: [MovieModel],_ error:Error?) -> Void)
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=\(pageNum)")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, respose, error) in
            do
            {
                let json  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                guard let result = json["results"] as? [[String:Any]] else {return}
                for i in 0..<result.count
                {
                    let dic = result[i]
                    let original_title = dic["original_title"] as? String ?? ""
                    let poster_path = dic["poster_path"] as? String ?? ""
                    let overview = dic["overview"] as? String ?? ""
                    let release_date = dic["release_date"] as? String ?? ""
                    let vote_average = dic["vote_average"] as? Double ?? 0
                    let id = dic["id"] as? Int ?? 0
                    if (original_title != "" && poster_path != "" && overview != "" && release_date != "" && vote_average != 0 && id != 0)
                    {
                        self.serialQueue.sync
                            {
                                MoviesServices.topRatedArr.append(MovieModel(original_title:original_title , poster_path: poster_path, overview: overview, release_date: release_date, vote_average: vote_average, id: id))
                        }
                    }
                }
                completion(MoviesServices.topRatedArr,nil)
            }
                
            catch
            {
                print("error")
            }
        }
        
        task.resume()
    }
    
    func mostPopularData(pageNum: Int,completion: @escaping (_ jsonData: [MovieModel],_ error:Error?) -> Void)
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=\(pageNum)")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){ (data, respose, error) in
            do
            {
                let json  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                guard let result = json["results"] as? [[String:Any]] else {return}
                for i in 0..<result.count
                {
                    let dic = result[i]
                    let original_title = dic["original_title"] as? String ?? ""
                    let poster_path = dic["poster_path"] as? String ?? ""
                    let overview = dic["overview"] as? String ?? ""
                    let release_date = dic["release_date"] as? String ?? ""
                    let vote_average = dic["vote_average"] as? Double ?? 0
                    let id = dic["id"] as? Int ?? 0
                    if (original_title != "" && poster_path != "" && overview != "" && release_date != "" && vote_average != 0 && id != 0)
                    {
                        self.serialQueue.sync
                            {
                                MoviesServices.mostPopularArr.append(MovieModel(original_title:original_title , poster_path: poster_path, overview: overview, release_date: release_date, vote_average: vote_average, id: id))
                        }
                    }
                }
                completion(MoviesServices.mostPopularArr,nil)
            }
            catch
            {
                print("error")
            }
        }
        task.resume()
    }
}



