//
//  HomePageModel.swift
//  VSMS
//
//  Created by Rathana on 7/9/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomePageModel {
    
    var product: Int = -1
    var title: String = ""
    var category: Int = 0
    var cost: String = "0.0"
    var imagefront: String = ""
    var discount: String = "0.0"
    var postType: String = ""
    
    init() {}
    
    init(id: Int, name: String, cost: String, imagefront: String){
        self.product = id
        self.title = name
        self.cost = cost
        self.imagefront = imagefront
    }
    
    init(id: Int, name: String, cost: String, imagefront: String,discount: String, postType: String){
        self.product = id
        self.title = name
        self.cost = cost
        self.imagefront = imagefront
        self.discount = discount
        self.postType = postType
    }
    
    init(json: JSON){
        self.product = json["id"].stringValue.toInt()
        self.title = json["title"].stringValue
        self.cost = json["cost"].stringValue
        self.discount = json["discount"].stringValue
        self.imagefront = json["front_image_base64"].stringValue
        self.postType = json["post_type"].stringValue
    }
}


class RelatedFilter {
    var type: String = ""
    var category: String = ""
    var modeling: String = ""
    var min_price: String = ""
    var max_price: String = ""
    
    init() {}
}


class SearchFilter{
    var search: String = ""
    var category: String = ""
    var brand: String = ""
    var year: String = ""
    var model: String = ""
    
    var modelings: [String] = []
    
    init() {}
}
