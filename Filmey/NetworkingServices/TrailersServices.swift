//
//  TrailersServices.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/6/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
class TrailerServices
    
{
    var trailers = [TrailerData]()
     func getTrailers(movieID: Int,completion: @escaping (_ jsonData: [TrailerData],_ error:Error?) -> Void) {
          let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)&language=en-US")
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
                      self.trailers.append(TrailerData(name: dic["name"] as! String, key: dic["key"] as! String, site: dic["site"] as! String, type: dic["type"] as! String))
                  }
                  
                  completion(self.trailers,nil)
                  
              }
                  
              catch
              {
                  print("error")
              }
          }
          
          
          task.resume()
      }
}
