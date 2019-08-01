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
    var AllPostNextPage: String?
    var AllPostPreviousePage: String?
    
    func LoadAllPosts(completion: @escaping ([HomePageModel]) -> Void){
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.HOMEPAGE,
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.AllPostNextPage = json["next"].stringValue
                    self.AllPostPreviousePage = json["previous"].stringValue
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
                    print(json)
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
    
    static func LoadAllPostByUser(completion: @escaping ([HomePageModel]) -> Void){
        var result: [HomePageModel] = []
        Alamofire.request(PROJECT_API.POSTBYUSERACTIVE,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers
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
                                      postType: $0["post_type"].stringValue
                        )}) ?? []
                    
                    performOn(.Main, closure: {
                        completion(result)
                    })
                case .failure:
                    print("error")
                }
        }
    }
    
    static func LoadAllPostLikeByUser(completion: @escaping ([String]) -> Void){
        var posts: [String] = []
        
        Alamofire.request(PROJECT_API.LIKEBYUSER,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    posts = json["results"].array?.map{
                            $0["post"].stringValue
                        } ?? []
                    
                    performOn(.Main, closure: {
                        completion(posts)
                    })
                case .failure:
                    print("error")
                }
        }.resume()
    }
    
    static func LoadListProductByPostID(postID: Int, completion: @escaping (HomePageModel) -> Void){
        var result = HomePageModel()
        Alamofire.request(PROJECT_API.LOADPRODUCT(ProID: postID),
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers
            ).responseJSON
            { response in
                switch response.result{
                case .success (let value):
                    let json = JSON(value)
                    result = HomePageModel(json: json)
                    completion(result)
                case .failure(_):
                    break
                }
        }
    }
}




class HomepageRequestHandler {
    var next: String = ""
    var previous: String = ""
    var count: Int = 0
    
    //Array Data
    var AllPostArr: [HomePageModel] = []
    
    init(){
    }
    
    func LoadAllPosts(completion: @escaping () -> Void){
        Alamofire.request(PROJECT_API.HOMEPAGE,
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.next = json["next"].stringValue
                    self.previous = json["previous"].stringValue
                    self.count = json["count"].stringValue.toInt()
                    
                    self.AllPostArr = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(),
                                      name: $0["title"].stringValue,
                                      cost: $0["cost"].stringValue,
                                      imagefront: $0["front_image_base64"].stringValue,
                                      discount: $0["discount"].stringValue,
                                      postType: $0["post_type"].stringValue,
                                      createdat: $0["created"].stringValue
                        )
                        }) ?? []
                    completion()
                case .failure:
                    print("error")
                }
        }
    }
    
    func LoadAllPostsNextPage(completion: @escaping () -> Void){
        if self.next == "" {
            return
        }

        Alamofire.request(self.next,
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.next = json["next"].stringValue
                    self.previous = json["previous"].stringValue
                    self.count = json["count"].stringValue.toInt()
                    
                    self.AllPostArr += (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(),
                                      name: $0["title"].stringValue,
                                      cost: $0["cost"].stringValue,
                                      imagefront: $0["front_image_base64"].stringValue,
                                      discount: $0["discount"].stringValue,
                                      postType: $0["post_type"].stringValue,
                                      createdat: $0["created"].stringValue)
                        }) ?? []
                    completion()
                case .failure:
                    print("error")
                }
        }
    }
    
    func IsEndofDataAllPost() -> Bool {
        return next == ""
    }
}

class UserProfileRequestHandle {
    
    var NextPostActive: String = ""
    var NextPostHistory: String = ""
    var NextLike: String = ""
    
    //Record count
    var AllPostActiveCount: Int = 0
    
    //List Data
    var PostActive: [HomePageModel] = []
    var PostHistory: [HomePageModel] = []
    
    init(){}
    
    func LoadAllPostByUser(completion: @escaping () -> Void){
        Alamofire.request(PROJECT_API.POSTBYUSERACTIVE,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.NextPostActive = json["next"].stringValue
                    self.AllPostActiveCount = json["count"].stringValue.toInt()

                    self.PostActive = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(),
                                      name: $0["title"].stringValue,
                                      cost: $0["cost"].stringValue,
                                      imagefront: $0["front_image_base64"].stringValue,
                                      discount: $0["discount"].stringValue,
                                      postType: $0["post_type"].stringValue,
                                      createdat: $0["created"].stringValue
                        )}) ?? []
                    
                        completion()

                case .failure:
                    print("error")
                }
        }
    }
    
    func NextPostByUser(completion: @escaping () -> Void){
        if self.NextPostActive == "" {
            return
        }
        
        Alamofire.request(self.NextPostActive,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers
            ).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.NextPostActive = json["next"].stringValue
                    self.AllPostActiveCount = json["count"].stringValue.toInt()
                    
                    self.PostActive += (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(),
                                      name: $0["title"].stringValue,
                                      cost: $0["cost"].stringValue,
                                      imagefront: $0["front_image_base64"].stringValue,
                                      discount: $0["discount"].stringValue,
                                      postType: $0["post_type"].stringValue,
                                      createdat: $0["created"].stringValue
                        )}) ?? []
                    
                    completion()
                    
                case .failure:
                    print("error")
                }
        }
    }
    
    func IsEndofDataNextPostActive() -> Bool {
        return self.NextPostActive == ""
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
                            case .success:
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
                            case .success:
                                completion()
                            case .failure(let error):
                                print(error)
                            }
        }
    }
}
