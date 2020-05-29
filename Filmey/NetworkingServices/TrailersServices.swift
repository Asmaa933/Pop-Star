//
//  TrailersServices.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/6/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TrailerServices{
    class func getTrailers(movieID: Int,completion: @escaping (_ jsonData: [TrailerData]?,_ error:Error?) -> Void){
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/videos"
        let parameters = ["api_key": apiKey , "language" : "en-US"]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseJSON{(response) in
            switch response.result{
            case .success:
                guard let data = response.data else {return}
                let trailers = parseJSON(data: data)
                completion(trailers,nil)
            case .failure(let error):
                completion(nil,error)
                print(error.localizedDescription)
                
            }
        }
    }
    private class func parseJSON(data: Data) -> [TrailerData] {
        var trailers = [TrailerData]()
        do{
            let json = try JSON(data: data)
            let result = json["results"]
            for item in 0..<result.count{
                let dic = result[item]
                let name = dic["name"].stringValue
                let key = dic["key"].stringValue
                let site = dic["site"].stringValue
                let type = dic["type"].stringValue
                trailers.append(TrailerData(name: name, key: key, site: site, type: type))
            }
        } catch(let error){
            print(error.localizedDescription)
        }
        return trailers
    }
    
}
