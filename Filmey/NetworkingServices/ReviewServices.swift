//
//  ReviewServices.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/11/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ReviewServices
{
    static func getReviewById(movieID: Int, pageNum: Int ,completion: @escaping (_ jsonData: [ReviewModel]?,_ error:Error?) -> Void)
    {
        var reviewArray = [ReviewModel]()
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/reviews?"
        let parameters : [String:Any] = ["api_key": apiKey , "language" : "en-US","page" : pageNum]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseJSON{(response) in
            switch response.result{
            case .success:
                guard let data = response.data else {return}
                do{
                    let json = try JSON(data: data)
                    let result = json["results"]
                    for item in 0..<result.count
                    {
                        let dic = result[item]
                        let author = dic["author"].stringValue
                        let content = dic["content"].stringValue
                        let total_pages = dic["total_pages"].intValue
                        
                        reviewArray.append(ReviewModel(author: author, content: content, total_pages: total_pages))

                        
                    }
                    completion(reviewArray,nil)
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
