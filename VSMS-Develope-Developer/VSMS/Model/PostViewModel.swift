//
//  PostViewModel.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/4/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import SwiftyJSON

class PostViewModel {
    var PostID: Int = -1
    var title: String = ""
    var post_type: String = ""
    var category: Int = 0
    var type: Int = 0
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
    var discount_type: String?
    var discount: String?
    
    //var discount_type: String = ""
    var contact_phone: String = User.getUsername()
    var contact_email: String = ""
    var contact_address: String = ""
    
    //Image
    var front_image_path: String?
    var right_image_path: String?
    var left_image_path: String?
    var back_image_path: String?
    
    var sale_post: [[String: Any]] = [[:]]
    var rent_post: [[String: Any]] = [[:]]
    var buy_post: [[String: Any]] = [[:]]
    
    
    //Constructor
    init(){
        
    }
    
    init(json: JSON) {
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

    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
}


class SalePost {
    var sale_status: Int = 2
    var record_status: Int = 2
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
}

class RentPost {
    var rent_status: Int = 2
    var record_status: Int = 2
    var rent_type: String = "" //day,week,month
    var rent_date: Date = Date()
    var return_date: Date = Date()
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
}


class BuyPost {
    var buy_status: Int = 2
    var record_status: Int = 2
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
}
