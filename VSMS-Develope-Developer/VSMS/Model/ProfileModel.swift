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
    var base64Img: String = ""
    
    init() {}
    
    init(id: Int, name: String, cost: String, base64Img: String){
        self.PosID = id
        self.title = name
        self.cost = cost
        self.base64Img = base64Img
    }
    
    init(json: JSON){
        
        self.PosID = json["id"].stringValue.toInt()
        self.title = json["title"].stringValue
        self.category = json["category"].stringValue.toInt()
        self.cost = json["cost"].stringValue
        self.base64Img = json["front_image_base64"].stringValue
        
        
    }
}

class ImageProfileModel {
    
    var profileID : String = ""
    var name: String = ""
   
    var profile: ImageSubClass = ImageSubClass()
    
    init(){}
    
  
    init(json: JSON){
        self.profileID = json["id"].stringValue
        self.name = json["username"].stringValue
        self.profile = ImageSubClass(json: json["profile"])
    }
    
}


class ImageSubClass {
    var telephone: String = ""
    var base64_profile_image: String = ""
    var base64_cover_image: String = ""
    
    
    init(){}
    
    init(json: JSON){
        self.telephone = json["telephone"].stringValue
        self.base64_profile_image = json["base64_profile_image"].stringValue
        self.base64_cover_image = json["base64_cover_image"].stringValue
    }
}


class LikebyUserModel {
    
    var post: Int = -1
    var likeby:  Int = -1
    
    init(post: Int,likeby: Int){
        self.post = post
        self.likeby = likeby
    }
    
    init(json: JSON) {
        self.post = json["post"].stringValue.toInt()
        self.likeby = json["like_by"].stringValue.toInt()
        
    }
    
}
