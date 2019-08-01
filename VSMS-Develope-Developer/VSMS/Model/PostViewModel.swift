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
    var user: Int = User.getUserID()
    
    
    //var discount_type: String = ""
    var name: String = ""
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
    
    
    //helper fields
    var PostTypeVal: String?
    var CategoryVal: String?
    var TypeVal: String?
    var BrandVal: String?
    var ModelVal: String?
    var YearVal: String?
    var ConditionVal: String?
    var ColorVal: String?
    var DiscountTypeVal: String?
    var TitleVal: String?
    var PriceVal: String?
    var DiscountVal: String?
    var NameVal: String?
    var PhoneNumberVal: String?
    var EmailVal: String?
    var AddressVal: String?
    
    //Constructor
    init(){
        
    }
    
    func LoadPostByID(ID: Int, completion: @escaping (PostViewModel) -> Void)
    {
        let result = PostViewModel()
        let semephore = DispatchGroup()
        
        semephore.enter()
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
                
                //get master data
                result.PostID = json["id"].stringValue.toInt()
                result.title = json["title"].stringValue
                result.post_type = json["post_type"].stringValue
                result.category = json["category"].stringValue.toInt()
                result.type = json["type"].stringValue.toInt()
                result.brand = json["brand"].stringValue.toInt()
                result.modeling = json["modeling"].stringValue.toInt()
                result.year = json["year"].stringValue.toInt()
                result.condition = json["condition"].stringValue
                result.color = json["color"].stringValue
                result.description = json["description"].stringValue
                result.status = json["status"].stringValue.toInt()
                result.discount_type = json["discount_type"].stringValue
                result.discount = json["discount"].stringValue
                result.cost = json["cost"].stringValue
                result.user = json["created_by"].stringValue.toInt()
                
                result.contact_phone = json["contact_phone"].stringValue
                result.contact_email = json["contact_email"].stringValue
                result.contact_address = json["contact_address"].stringValue
                
                result.front_image_base64 = json["front_image_base64"].stringValue
                result.left_image_base64 = json["left_image_base64"].stringValue
                result.right_image_base64 = json["right_image_base64"].stringValue
                result.back_image_base64 = json["back_image_base64"].stringValue
                
                result.front_image_path = result.front_image_base64
                result.left_image_path = result.left_image_base64
                result.right_image_path = result.right_image_base64
                result.back_image_path = result.back_image_base64
                semephore.leave()
                
                if result.post_type == "sell"
                {
                    result.sale_post = JSON(json["sales"]).arrayValue.map{
                        SalePost(json: $0).asDictionary
                    }
                }
                else if result.post_type == "buy"
                {
                    result.buy_post = JSON(json["buys"]).arrayValue.map{
                        BuyPost(json: $0).asDictionary
                    }
                }
                else if result.post_type == "rents"
                {
                    result.rent_post = JSON(json["rents"]).arrayValue.map{
                        RentPost(json: $0).asDictionary
                    }
                }
                
                
                result.PostTypeVal = json["post_type"].stringValue.capitalizingFirstLetter()
                result.ConditionVal = result.condition.capitalizingFirstLetter()
                result.ColorVal = result.color.capitalizingFirstLetter()
                result.DiscountTypeVal = result.discount_type.capitalizingFirstLetter()
                result.TitleVal = result.title
                result.PriceVal = result.cost
                result.DiscountVal = result.discount
                result.PhoneNumberVal = result.contact_phone
                result.EmailVal = result.contact_email
                result.AddressVal = result.contact_address
                
                semephore.enter()
                Converts.getCategorybyID(id: result.category, completion: { (category) in
                    result.CategoryVal = category
                    semephore.leave()
                })
                
                semephore.enter()
                Converts.getTypebyID(id: result.type, completion: { (type) in
                    result.TypeVal = type
                    semephore.leave()
                })
                
                semephore.enter()
                Converts.getBrandbyModeID(id: result.modeling, completion: { (brand) in
                    result.BrandVal = brand
                    semephore.leave()
                })
                
                semephore.enter()
                Converts.getBrandIDbyModelID(ModelID: result.modeling.toString(), completion: { (brandID) in
                    result.brand = brandID.toInt()
                    semephore.leave()
                })
                
                semephore.enter()
                Converts.getModelbyID(id: result.modeling, completion: { (model) in
                    result.ModelVal = model
                    semephore.leave()
                })
                
                semephore.enter()
                Converts.getYearbyID(id: result.year, completion: { (year) in
                    result.YearVal = year
                    semephore.leave()
                })
                
                semephore.notify(queue: .main, execute: {
                    completion(result)
                })
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
    
    var asParameters: [String: Any]
    {
        let parameter: Parameters =
        [
            "id": self.PostID,
            "title": self.title,
            "post_type": self.post_type,
            "category": self.category,
            "type": self.type,
            "brand": self.brand,
            "modeling": self.modeling,
            "year": self.year,
            "condition": self.condition,
            "color": self.color,
            "description": self.description,
            "cost": self.cost,
            "discount_type": self.discount_type,
            "discount": self.discount,
            "status": self.status
        ]
        return parameter
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
    
    init(id: Int, saleStatus: Int, recordStatus: Int, SoldDate: Date?, price: String, total: String) {
        self.id = id
        self.sale_status = saleStatus
        self.record_status = recordStatus
        self.sold_date = SoldDate
        self.price = price
        self.total_price = total
    }
    
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
        self.rent_status = json["rent_status"].stringValue.toInt()
        self.record_status = json["record_status"].stringValue.toInt()
        self.rent_type = json["rent_type"].stringValue
        //self.rent_date = json["rent_date"].stringValue
        self.total_price = json["total_price"].stringValue
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
        self.buy_status = json["buy_status"].stringValue.toInt()
        self.record_status = json["record_status"].stringValue.toInt()
        self.total_price = json["total_price"].stringValue
    }
}
