//
//  AccountViewModel.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/6/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AccountViewModel {
    var id: Int?
    var username: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""
    var group: [Int] = []
    var password: String = User.getPassword()
    
    var ProfileData = AccountSubProfile()
    
    var asDictionary : [String:Any] {
        let parameter: Parameters = [
            "id": self.id,
            "username": self.username,
            "firstname": self.firstname,
            "lastname": self.lastname,
            "email": self.email,
            "groups": [self.group[0]],
            "password": self.password,
            "profile": self.ProfileData.asDictionary
        ]
        return parameter
    }
    
    init() {}
    
    func LoadUserAccount(completion: @escaping () -> Void)
    {
        Alamofire.request(PROJECT_API.GETUSERDETAIL(ID: User.getUserID()),
                          method: .get,
                          encoding: JSONEncoding.default
            ).responseJSON { (respone) in
                switch respone.result {
                case .success(let value):
                    let json = JSON(value)
                    let profile = json["profile"]
                    
                    self.id = json["id"].stringValue.toInt()
                    self.username = json["username"].stringValue
                    self.firstname = json["firstname"].stringValue
                    self.lastname = json["lastname"].stringValue
                    self.email = json["email"].stringValue
                    self.group = json["groups"].arrayValue.map{ $0.stringValue.toInt() }
                    
                    self.ProfileData.gender = profile["gender"].stringValue
                    self.ProfileData.date_of_birth = profile["date_of_birth"].stringValue
                    self.ProfileData.telephone = profile["telephone"].stringValue
                    self.ProfileData.address = profile["address"].stringValue
                    self.ProfileData.province = profile["province"].stringValue.toInt()
                    self.ProfileData.marital_status = profile["marital_status"].stringValue
                    self.ProfileData.wing_account_name = profile["wing_account_name"].stringValue
                    self.ProfileData.wing_account_number = profile["wing_account_number"].stringValue
                    self.ProfileData.place_of_birth = profile["place_of_birth"].stringValue.toInt()
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func UpdateUserAccount(completion: @escaping () -> Void)
    {
        
        Alamofire.request(PROJECT_API.GETUSERDETAIL(ID: self.id!),
                          method: .patch,
                          parameters: self.asDictionary,
                          encoding: JSONEncoding.default,
                          headers: headers
            ).responseJSON { (respone) in
                switch respone.result
                {
                case .success:
                    completion()
                case .failure(let error):
                    print(error)
                }
        }
    }
}

class AccountSubProfile{
    var gender: String = ""
    var date_of_birth: String = ""
    var telephone: String = ""
    var address: String = ""
    var province: Int?
    var marital_status: String = ""
    var wing_account_name: String = ""
    var wing_account_number: String = ""
    var place_of_birth: Int?
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
    
    init() {}
    
    
}
