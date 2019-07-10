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
    
    
    init(id: Int, name: String, cost: String, imagefront: String){
        self.product = id
        self.title = name
        self.cost = cost
        self.imagefront = imagefront
    }
    
    init(id: Int, name: String, cost: String, imagefront: String,discount: String){
        self.product = id
        self.title = name
        self.cost = cost
        self.imagefront = imagefront
        self.discount = discount
    }
    
    init(json: JSON){
        self.product = json["id"].stringValue.toInt()
        self.title = json["title"].stringValue
        self.cost = json["cost"].stringValue
        self.imagefront = json["front_image_base64"].stringValue
    }
    
    
    
}
