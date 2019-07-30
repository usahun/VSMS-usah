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

var headers: HTTPHeaders = [
    "Cookie": "",
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization" : User.getUserEncoded(),
]


class RequestHandle {
    
    static func LoadAllPosts(completion: @escaping ([HomePageModel]) -> Void){
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.HOMEPAGE,
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    result = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(),
                                      name: $0["title"].stringValue,
                                      cost: $0["cost"].stringValue,
                                      imagefront: $0["front_image_base64"].stringValue,
                                      discount: $0["discount"].stringValue,
                                      postType: $0["post_type"].stringValue)
                        }) ?? []
                    
                    performOn(.Main, closure: {
                        completion(result)
                    })
                case .failure:
                    print("error")
                }
        }
    }
    
    static func LoadRelated(postType: String, category: String, modeling: String, completion: @escaping ([HomePageModel]) -> Void){
       // print(PROJECT_API.RELATED_PRODUCT(postType: postType, category: category, modeling: modeling))
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.RELATED_PRODUCT(postType: postType, category: category, modeling: modeling),
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    result = (json["results"].array?.map{
                       HomePageModel(id: $0["id"].stringValue.toInt()
                        , name: $0["title"].stringValue,
                          cost: $0["cost"].stringValue,
                          imagefront: $0["front_image_base64"].stringValue,
                          discount: $0["discount"].stringValue, postType: $0["post_type"].stringValue)
                        }) ?? []
                    
                    completion(result)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    static func LoadBestDeal(completion: @escaping ([HomePageModel]) -> Void){
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.BESTDEAL,
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    result = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["front_image_base64"].stringValue,discount: $0["discount"].stringValue, postType: $0["post_type"].stringValue)
                        }) ?? []
                    performOn(.Main, closure: {
                        completion(result)
                    })
                case .failure:
                    print("error")
                }
        }
       
    }
    
    static func CountView(postID: Int, completion: @escaping (Int) -> Void){
        Alamofire.request(PROJECT_API.COUNT_VIEWS(ProID: postID),
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                   // print(json)
                    completion(json["count"].stringValue.toInt())
                case .failure:
                    print("error")
                }
        }
        
    }
    
    static func LoadAllPostByPostTypeAndCategory(filter: RelatedFilter, completion: @escaping ([HomePageModel]) -> Void) {
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.RELATED_PRODUCT(postType: filter.type, category: filter.category, modeling: filter.modeling),
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    result = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["front_image_base64"].stringValue, discount: $0["discount"].stringValue, postType: $0["post_type"].stringValue)
                        }) ?? []
                    
                    performOn(.Main, closure: {
                        completion(result)
                    })
                case .failure:
                    print("error")
                }
        }
    }
    
    
    
    static func SearchProduct(filter: SearchFilter, completion: @escaping ([HomePageModel]) -> Void) {
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.SEARCH_PRODUCT(filter: filter),
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    result = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["front_image_base64"].stringValue, discount: $0["discount"].stringValue, postType: $0["post_type"].stringValue)
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


extension UIImage {
    func UpLoadCover(completion: @escaping () -> Void){
        let parameters: Parameters = [
            "profile": [
                "cover_photo": self.toBase64()
            ]
        ]
        Alamofire.request(PROJECT_API.COVER_PIC,
                          method: .put,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON { response in
                            switch response.result{
                            case .success (let value):
                                completion()
                            case .failure(let error):
                                print(error)
                            }
        }
    }
    
    func UpLoadProfile(completion: @escaping () -> Void){
        let parameters: Parameters = [
            "profile": [
                "profile_photo": self.toBase64()
            ]
        ]
        Alamofire.request(PROJECT_API.PROFILE_PIC,
                          method: .put,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON { response in
                            switch response.result{
                            case .success (let value):
                                completion()
                            case .failure(let error):
                                print(error)
                            }
        }
    }
}
