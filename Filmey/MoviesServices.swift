//
//  NowPlayingServices.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/4/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
class MoviesServices{
    var nowPlayingArr = [movieModel]()
    var topRatedArr = [movieModel]()
    var mostPopularArr = [movieModel]()
    func nowPlayingData(completion: @escaping (_ jsonData: [movieModel],_ error:Error?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1"
        )
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, respose, error) in
            do
            {
                let json  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let result = json["results"] as! [[String:Any]]
                for i in 0..<result.count
                {
                    let dic = result[i]
                    self.nowPlayingArr.append(movieModel(original_title: dic["original_title"] as! String, poster_path: dic["poster_path"] as! String, overview: dic["overview"] as! String , release_date: dic["release_date"] as! String, vote_average: dic["vote_average"] as! Double, id: dic["id"] as! Int))
                }
                
                completion(self.nowPlayingArr,nil)
                
            }
                
            catch
            {
                print("error")
            }
        }
        
        
        task.resume()
    }
    
    func topRatedData(completion: @escaping (_ jsonData: [movieModel],_ error:Error?) -> Void)
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        )
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, respose, error) in
            do
            {
                let json  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let result = json["results"] as! [[String:Any]]
                for i in 0..<result.count
                {
                    let dic = result[i]
                    self.topRatedArr.append(movieModel(original_title: dic["original_title"] as! String, poster_path: dic["poster_path"] as! String, overview: dic["overview"] as! String , release_date: dic["release_date"] as! String, vote_average: dic["vote_average"] as! Double, id: dic["id"] as! Int))
                }
                
                completion(self.topRatedArr,nil)
                
            }
                
            catch
            {
                print("error")
            }
        }

        task.resume()
        
    }
    func mostPopularData(completion: @escaping (_ jsonData: [movieModel],_ error:Error?) -> Void)
       {
           let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
           )
           let request = URLRequest(url: url!)
           let session = URLSession(configuration: URLSessionConfiguration.default)
           let task = session.dataTask(with: request) { (data, respose, error) in
               do
               {
                   let json  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                   let result = json["results"] as! [[String:Any]]
                   for i in 0..<result.count
                   {
                       let dic = result[i]
                       self.mostPopularArr.append(movieModel(original_title: dic["original_title"] as! String, poster_path: dic["poster_path"] as! String, overview: dic["overview"] as! String , release_date: dic["release_date"] as! String, vote_average: dic["vote_average"] as! Double, id: dic["id"] as! Int))
                   }
                   
                   completion(self.mostPopularArr,nil)
                   
               }
                   
               catch
               {
                   print("error")
               }
           }

           task.resume()
           
       }
}



