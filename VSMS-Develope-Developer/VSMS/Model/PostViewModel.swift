//
//  PostViewModel.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/4/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class PostViewModel {
    var PostID: Int = -1
    var title: String = ""
    var post_type: String = ""
    var category: Int = 0
    var type: Int = 1
    var brand: Int = 0
    var modeling: Int = 0
    var year: Int = 0
    var condition: String = ""
    var color: String = ""
    var vin_code: String = ""
    var machine_code: String = ""
    var description: String = ""
    var cost: String = "0.0"
    var created_by: Int = User.getUserID()
    var discount_type: String = "amount"
    var discount: String = "0.0"
    var status: Int = 1
    
    //var discount_type: String = ""
    var contact_phone: String = User.getUsername()
    var contact_email: String = ""
    var contact_address: String = ""
    
    //Image
    var front_image_path: String?
    var front_image_base64: String?
    
    var right_image_path: String?
    var right_image_base64: String?
    
    var left_image_path: String?
    var left_image_base64: String?
    
    var back_image_path: String?
    var back_image_base64: String?
    
    //Array Post
    var sale_post: [[String: Any]] = [[:]]
    var rent_post: [[String: Any]] = [[:]]
    var buy_post: [[String: Any]] = [[:]]
    
    
    //Constructor
    init(){
        
    }
    
    func LoadPostByID(ID: Int, completion: @escaping (PostViewModel) -> Void)
    {
        var result = PostViewModel()
        Alamofire.request(PROJECT_API.LOADPRODUCTOFUSER(ProID: ID),
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers
        ).responseJSON
        { response in
            switch response.result
            {
            case .success(let value):
                let json = JSON(value)
                result.front_image_base64 = json["front_image_base64"].stringValue
                result.left_image_base64 = json["left_image_base64"].stringValue
                result.right_image_base64 = json["right_image_base64"].stringValue
                result.back_image_base64 = json["back_image_base64"].stringValue
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init(json: JSON)
    {
        self.PostID = json["id"].stringValue.toInt()
        self.title = json["title"].stringValue
        self.post_type = json["post_type"].stringValue
        self.category = json["category"].stringValue.toInt()
        self.type = json["type"].stringValue.toInt()
        self.brand = json["brand"].stringValue.toInt()
        self.modeling = json["model"].stringValue.toInt()
        self.year = json["year"].stringValue.toInt()
        self.condition = json["condition"].stringValue
    }

    var asDictionary : [String:Any]
    {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
}


class SalePost {
    var id: Int = -1
    var sale_status: Int = 3
    var record_status: Int = 1
    var sold_date: Date?
    var price: String = ""
    var total_price: String = ""
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
    
    init() {}
    
    init(json: JSON)
    {
        self.id = json["id"].stringValue.toInt()
        self.sale_status = json["sale_status"].stringValue.toInt()
        self.record_status = json["record_status"].stringValue.toInt()
        //self.sold_date = json["sold_date"].stringValue.to
        self.price = json["price"].stringValue
        self.total_price = json["total_price"].stringValue
    }
}

class RentPost {
    var id: Int = -1
    var rent_status: Int = 3
    var record_status: Int = 1
    var rent_type: String = "month" //day,week,month
    var rent_date: Date?
    var return_date: Date?
    var price: String = ""
    var total_price: String = ""
    var rent_count_number: Int = 0
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
    
    init() {}
    
    init(json: JSON){
        self.id = json["id"].stringValue.toInt()
    }
}


class BuyPost {
    var id: Int = -1
    var buy_status: Int = 3
    var record_status: Int = 1
    var created: Date?
    //var post: Int = 3
    var total_price: String = ""
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
    
    init() {}
    
    init(json: JSON){
        self.id = json["id"].stringValue.toInt()
    }
}
