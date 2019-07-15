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

var http_absoluteString = "http://103.205.26.103:8000"


class PROJECT_API {
    static var CATEGORIES = "\(http_absoluteString)/api/v1/categories/"
    static var MODELS = "\(http_absoluteString)/api/v1/models/"
    static var BRANDS = "\(http_absoluteString)/api/v1/brands/"
    static var YEARS = "\(http_absoluteString)/api/v1/years/"
    static var TYPES = "\(http_absoluteString)/api/v1/types/"
    static var STATUS = "\(http_absoluteString)/api/v1/status/"
    static var PROVINCES = "\(http_absoluteString)/api/v1/provinces/"
    
    static var POST_BYUSER = "\(http_absoluteString)/postbyuser/"
    static var LOGIN = "\(http_absoluteString)/api/v1/rest-auth/login/"
    
    
    static var USER = "\(http_absoluteString)/api/v1/users/\(User.getUserID())/"
    static var HOMEPAGE = "\(http_absoluteString)/allposts/"
    static var LIKEBYUSER = "\(http_absoluteString)/likebyuser/"
    static var BESTDEAL = "\(http_absoluteString)/bestdeal/"
    
    static var POST_BUYS = "\(http_absoluteString)/api/v1/postbuys/"
    static var POST_RENTS = "\(http_absoluteString)/postrent/"
    static var POST_SELL = "\(http_absoluteString)/postsale/"

    
    static func LOADPRODUCT(ProID: Int) -> String {
        return "\(http_absoluteString)/allposts/\(ProID)/"
    }
    static func GETUSERDETAIL(ID: Int) -> String {
        return "\(http_absoluteString)/api/v1/users/\(ID)/"

    static func LOADPRODUCT(ProLD: Int) -> String {
        return "\(http_absoluteString)/allposts/\(ProLD)"

    }
}


class User {
    static func getUserID() -> Int {
        let defaultValues = UserDefaults.standard
        return Int(defaultValues.string(forKey: "userid") ?? "0") ?? 0
    }
    
    static func getUsername() -> String {
        let defaultValues = UserDefaults.standard
        return defaultValues.string(forKey: "username") ?? ""
    }
    
    static func getUserEncoded() -> String {
        let defaultValues = UserDefaults.standard
        let username = defaultValues.string(forKey: "username") ?? ""
        let password = defaultValues.string(forKey: "password") ?? ""

        let userPass = username + ":" + password
        return "Basic " + userPass.base64Encoded()!
    }
    
    static func IsAuthenticated(view: UIViewController, callBack: (() -> Void)) {
        let defaultValues = UserDefaults.standard
        if defaultValues.string(forKey: "username") == nil{
            let LogInView = view.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            view.navigationController?.pushViewController(LogInView, animated: true)
        }
        else{
            return
        }
    }
    
    static func getUserInfo(id: Int, completion: @escaping (Profile) -> ()) {
        Alamofire.request(PROJECT_API.GETUSERDETAIL(ID: id), method: .get, encoding: JSONEncoding.default).responseJSON { (respone) in
            switch respone.result {
            case .success(let value):
                let json = JSON(value)
                let profile = json["profile"]
                completion(Profile(ID: json["id"].stringValue,
                                   Name: json["username"].stringValue,
                                   PhoneNumber: profile["telephone"].stringValue,
                                   Email: json["email"].stringValue,
                                   Profile: profile["base64_profile_image"].stringValue.base64ToImage() ?? UIImage()))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

class Converts {

    static func getBrandbyID(id: Int, completion: @escaping (String) -> ()){
        Alamofire.request("\(PROJECT_API.BRANDS)\(id)/", method: .get, encoding: JSONEncoding.default).responseJSON { (respone) in
            switch respone.result {
            case .success(let value):
                let json = JSON(value)
                completion(json["brand_name"].stringValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getYearbyID(id: Int, completion: @escaping (String) -> ()){
        Alamofire.request("\(PROJECT_API.YEARS)\(id)/", method: .get, encoding: JSONEncoding.default ).responseJSON { (respone) in
            switch respone.result {
            case .success(let value):
                let json = JSON(value)
                completion(json["year"].stringValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getCategorybyID(id: Int, completion: @escaping (String) -> ()){
        Alamofire.request("\(PROJECT_API.CATEGORIES)\(id)/", method: .get, encoding: JSONEncoding.default ).responseJSON { (respone) in
            switch respone.result {
            case .success(let value):
                let json = JSON(value)
                completion(json["cat_name"].stringValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getTypebyID(id: Int, completion: @escaping (String) -> ()){
        Alamofire.request("\(PROJECT_API.TYPES)\(id)/", method: .get, encoding: JSONEncoding.default ).responseJSON { (respone) in
            switch respone.result {
            case .success(let value):
                let json = JSON(value)
                completion(json["type"].stringValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getModelbyID(id: Int, completion: @escaping (String) -> ()){
        Alamofire.request("\(PROJECT_API.MODELS)\(id)/", method: .get, encoding: JSONEncoding.default ).responseJSON { (respone) in
            switch respone.result {
            case .success(let value):
                let json = JSON(value)
                completion(json["modeling_name"].stringValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getBrandbyModeID(id: Int, completion: @escaping (String) -> ()){
        Alamofire.request("\(PROJECT_API.MODELS)\(id)/", method: .get, encoding: JSONEncoding.default ).responseJSON { (respone) in
            switch respone.result {
            case .success(let value):
                let json = JSON(value)
                let BrandID = json["brand"].stringValue
                Converts.getBrandbyID(id: BrandID.toInt(), completion: { (val) in
                    completion(val)
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}



class Functions {
    
    static func getDiscountTypeList() -> [String] {
        return ["Amount", "Percentage"]
    }
    
    
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


