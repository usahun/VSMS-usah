//
//  Functions.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/4/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PROJECT_API {
    static var CATEGORIES = "http://103.205.26.103:8000/api/v1/categories/"
    static var MODELS = "http://103.205.26.103:8000/api/v1/models/"
    static var BRANDS = "http://103.205.26.103:8000/api/v1/brands/"
    static var YEARS = "http://103.205.26.103:8000/api/v1/years/"
    static var TYPES = "http://103.205.26.103:8000/api/v1/types/"
    static var STATUS = "http://103.205.26.103:8000/api/v1/status/"
    static var PROVINCES = "http://103.205.26.103:8000/api/v1/provinces/"
    static var POST_BYUSER = "http://103.205.26.103:8000/postbyuser/"
    static var LOGIN = "http://103.205.26.103:8000/api/v1/rest-auth/login/"
    
    static var USER = "http://103.205.26.103:8000/api/v1/users/"
    static var HOMEPAGE = "http://103.205.26.103:8000/allposts/"
    static var LIKEBYUSER = "http://103.205.26.103:8000/likebyuser/"
    static var BESTDEAL = "http://103.205.26.103:8000/bestdeal/"
    
    static var POST_BUYS = "http://103.205.26.103:8000/api/v1/postbuys/"
    static var POST_RENTS = "http://103.205.26.103:8000/postrent/"
    static var POST_SELL = "http://103.205.26.103:8000/postsale/"
}

class User {
    static func getUserID() -> Int {
        let defaultValues = UserDefaults.standard
        return Int(defaultValues.string(forKey: "userid")!)!
    }
    
    static func getUsername() -> String {
        let defaultValues = UserDefaults.standard
        return defaultValues.string(forKey: "username") ?? ""
    }
    
    static func getUserEncoded() -> String {
        let defaultValues = UserDefaults.standard
        let username = defaultValues.string(forKey: "username")!
        let password = defaultValues.string(forKey: "password")!
        let userPass = username + ":" + password
        
        
        return "Basic " + userPass.base64Encoded()!
    }
}

class Functions {
    
    
    static func getDropDownList(key: Int ,completion: @escaping ([dropdownData]) -> ()){
        switch key{
        case 0:
            completion([dropdownData(ID: "buy", Text: "Buy", FKKey: ""),
                        dropdownData(ID: "rent", Text: "Rent", FKKey: ""),
                        dropdownData(ID: "sell", Text: "Sell", FKKey: "")])
            break
        case 2:
            //Category
            Alamofire.request(PROJECT_API.CATEGORIES, method: .get, encoding: JSONEncoding.default).responseJSON { (respone) in
                switch respone.result {
                case .success(let value):
                    let json = JSON(value)
                    let arrData = json["results"].array?.map {
                        dropdownData(ID: $0["id"].stringValue,
                                     Text: $0["cat_name"].stringValue,
                                     FKKey: "")
                    }
                    completion(arrData ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            break
        case 3:
            //Type
            Alamofire.request(PROJECT_API.TYPES, method: .get, encoding: JSONEncoding.default).responseJSON { (respone) in
                switch respone.result {
                case .success(let value):
                    let json = JSON(value)
                    let arrData = json["results"].array?.map {
                        dropdownData(ID: $0["id"].stringValue,
                                     Text: $0["type"].stringValue,
                                     FKKey: "")
                    }
                    completion(arrData ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            break
        case 4:
            //Brand
            Alamofire.request(PROJECT_API.BRANDS, method: .get, encoding: JSONEncoding.default).responseJSON { (respone) in
                switch respone.result {
                case .success(let value):
                    let json = JSON(value)
                    let arrData = json["results"].array?.map {
                        dropdownData(ID: $0["id"].stringValue,
                                     Text: $0["brand_name"].stringValue,
                                     FKKey: "")
                    }
                    completion(arrData ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            break
        case 5:
            //Model
            Alamofire.request(PROJECT_API.MODELS, method: .get, encoding: JSONEncoding.default).responseJSON { (respone) in
                switch respone.result {
                case .success(let value):
                    let json = JSON(value)
                    let arrData = json["results"].array?.map {
                        dropdownData(ID: $0["id"].stringValue,
                                     Text: $0["modeling_name"].stringValue,
                                     FKKey: $0["brand"].stringValue)
                    }
                    completion(arrData ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            break
        case 6:
            //years
            Alamofire.request(PROJECT_API.YEARS, method: .get, encoding: JSONEncoding.default).responseJSON { (respone) in
                switch respone.result {
                case .success(let value):
                    let json = JSON(value)
                    let arrData = json["results"].array?.map {
                        dropdownData(ID: $0["id"].stringValue,
                                     Text: $0["year"].stringValue,
                                     FKKey: "")
                    }
                
                    completion(arrData ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            break
        case 7:
            //Condition
            completion([dropdownData(ID: "new", Text: "New", FKKey: ""),
                        dropdownData(ID: "used", Text: "Used", FKKey: "")])
            break
        case 8:
            //Color
            completion([dropdownData(ID: "blue", Text: "Blue", FKKey: ""),
                        dropdownData(ID: "black", Text: "Black", FKKey: ""),
                        dropdownData(ID: "silver", Text: "Silver", FKKey: ""),
                        dropdownData(ID: "red", Text: "Red", FKKey: ""),
                        dropdownData(ID: "gray", Text: "Gray", FKKey: ""),
                        dropdownData(ID: "yellow", Text: "Yellow", FKKey: ""),
                        dropdownData(ID: "pink", Text: "Pink", FKKey: ""),
                        dropdownData(ID: "purple", Text: "Purple", FKKey: ""),
                        dropdownData(ID: "orange", Text: "Orange", FKKey: ""),
                        dropdownData(ID: "green", Text: "Green", FKKey: ""),])
            break
        default:
            print("OK")
        }
    }
    
}



extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func base64ToImage() -> UIImage?{
        let imageData = NSData(base64Encoded: self ,options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        return UIImage(data: imageData! as Data) ?? UIImage()
    }
}

extension Int {
    func toString() -> String {
        return "\(self)"
    }
}


