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
    
    static var POST_BUYS = "\(http_absoluteString)/api/v1/postbuys/"
    static var POST_RENTS = "\(http_absoluteString)/postrent/"
    static var POST_SELL = "\(http_absoluteString)/postsale/"
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
        let username = defaultValues.string(forKey: "username")!
        let password = defaultValues.string(forKey: "password")!
        let userPass = username + ":" + password
        return "Basic " + userPass.base64Encoded()!
    }
    
    static func IsAuthenticated(view: UIViewController) {
        let defaultValues = UserDefaults.standard
        if defaultValues.string(forKey: "username") == nil{
            let LogInView = view.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            view.navigationController?.pushViewController(LogInView, animated: true)
        }
        else{
            return
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


