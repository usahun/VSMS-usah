//
//  FirebaseHandle.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/22/19.
//  Copyright © 2019 121. All rights reserved.
//

import Alamofire
import Foundation
import Firebase
import SwiftyJSON


class FireBaseRealTime
{
    static var USER = "Testing"
}


class UserFireBase
{
    var id: String = ""
    var username: String = ""
    var password: String = ""
    var imageURL: String = "default"
    var coverURL: String = "default"
    var search: String = ""
    var status: String = "online"
    
    init() { }
    
    init(json: JSON)
    {
        self.id = json["id"].stringValue
        self.username = json["username"].stringValue
        self.password = json["password"].stringValue
        self.search = json["search"].stringValue
        self.imageURL = json["imageURL"].stringValue
        self.coverURL = json["coverURL"].stringValue
        self.status = json["status"].stringValue
    }

    static func Load(_ completion: @escaping ((UserFireBase) -> Void))
    {
        Auth.auth().addIDTokenDidChangeListener { (auth, user) in
            if user != nil
            {
                let userFirebase = Database.database().reference().child(FireBaseRealTime.USER).child(user!.uid)
                userFirebase.observe(.value, with: { (snapShot) in
                    let data = JSON(snapShot.value as Any)
                    completion(UserFireBase(json: data))
                })
            }
        }
    }
    
    func Save(_ completion: @escaping (() -> Void))
    {
        let user = Database.database().reference().child(FireBaseRealTime.USER)
        user.child(self.id).setValue(self.asDictionary) { (error, dbReferrenc) in
            completion()
        }
    }
    
    func Update(_ completion: @escaping (() -> Void))
    {
        Auth.auth().addIDTokenDidChangeListener { (auth, user) in
            if user != nil
            {
                if user?.uid == self.id
                {
                    let userUpdate = Database.database().reference().child(FireBaseRealTime.USER).child(user!.uid)
                    userUpdate.setValue(self.asDictionary, withCompletionBlock: { (error, dbReference) in
                        completion()
                    })
                }
            }
        }
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


