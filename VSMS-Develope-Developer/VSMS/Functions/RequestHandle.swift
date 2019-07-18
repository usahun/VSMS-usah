//
//  RequestHandle.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class RequestHandle {
    
    static func LoadAllPosts(completion: @escaping ([HomePageModel]) -> Void){
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.HOMEPAGE, method: .get,encoding: JSONEncoding.default).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    result = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["front_image_base64"].stringValue)
                        }) ?? []
                    
                    performOn(.Main, closure: {
                        completion(result)
                    })
                case .failure:
                    print("error")
                }
        }
    }
    
    static func LoadBestDeal(completion: @escaping ([HomePageModel]) -> Void){
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.BESTDEAL, method: .get,encoding: JSONEncoding.default).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    result = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["front_image_base64"].stringValue,discount: $0["discount"].stringValue)
                        }) ?? []
                    performOn(.Main, closure: {
                        completion(result)
                    })
                case .failure:
                    print("error")
                }
        }
    }

}

