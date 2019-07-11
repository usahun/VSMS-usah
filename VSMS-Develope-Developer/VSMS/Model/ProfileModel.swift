//
//  ProfileModel.swift
//  VSMS
//
//  Created by Rathana on 7/6/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ProfileModel {
    
    var PosID: Int = -1
    var title: String = ""
    var category: Int = 0
    var condition: String = ""
    var cost: String = "0.0"
    
    
    init(id: Int, name: String, cost: String){
        self.PosID = id
        self.title = name
        self.cost = cost
    }
    
    init(json: JSON){
        
        self.PosID = json["id"].stringValue.toInt()
        self.title = json["title"].stringValue
        self.category = json["category"].stringValue.toInt()
        self.cost = json["cost"].stringValue
        
        
    }
}




