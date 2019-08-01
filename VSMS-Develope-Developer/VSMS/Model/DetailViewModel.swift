//
//  DetailViewModel.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/12/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DetailViewModel {
    var id: Int = -1
    var title: String = ""
    var category: Int = -1
    var condition: String = ""
    var discount_type: String = ""
    var discount: String = ""
    var created_by: Int = -1
    var year: Int = -1
    var brand: Int = -1
    var modeling: Int = -1
    var type: Int = -1
    var description: String = ""
    var cost: String = ""
    var post_type: String = ""
    var vin_code: String = ""
    var machine_code: String = ""
    var contact_phone: String = ""
    var contact_email: String = ""
    var contact_address: String = ""
    var color: String = ""
    var sales: [SalePost] = []
    var buys: [BuyPost] = []
    var rents: [RentPost] = []
    
    var front_image_base64: UIImage?
    var back_image_base64: UIImage?
    var left_image_base64: UIImage?
    var right_image_base64: UIImage?
    
    //additionalFileds
    var arrImage: [UIImage] = []
    var getYear: String = ""
    var getBrand: String = ""
    var getModel: String = ""
    var getType: String = ""
    var UserProfile: Profile?
    
    init() {
        
    }
    
    init(json: JSON){
        self.id = json["id"].stringValue.toInt()
        self.title = json["title"].stringValue
        self.category = json["category"].stringValue.toInt()
        self.condition = json["condition"].stringValue
        self.discount_type = json["discount_type"].stringValue
        self.discount = json["discount"].stringValue
        self.created_by = json["created_by"].stringValue.toInt()
        self.year = json["year"].stringValue.toInt()
        self.brand = json["brand"].stringValue.toInt()
        self.modeling = json["modeling"].stringValue.toInt()
        self.type = json["modeling"].stringValue.toInt()
        self.color = json["color"].stringValue
        self.description = json["description"].stringValue
        self.cost = json["cost"].stringValue
        self.post_type = json["post_type"].stringValue
        self.vin_code = json["vin_code"].stringValue
        self.machine_code = json["machine_code"].stringValue
        self.created_by = json["created_by"].stringValue.toInt()
        
        self.contact_phone = json["contact_phone"].stringValue
        self.contact_email = json["contact_email"].stringValue
        self.contact_address = json["contact_address"].stringValue
        
        self.sales = [SalePost(json: json["sales"])]
        self.rents = [RentPost(json: json["rents"])]
        self.buys = [BuyPost(json: json["buys"])]
        
        self.front_image_base64 = json["front_image_base64"].stringValue.base64ToImage()
        self.left_image_base64 = json["left_image_base64"].stringValue.base64ToImage()
        self.right_image_base64 = json["right_image_base64"].stringValue.base64ToImage()
        self.back_image_base64 = json["back_image_base64"].stringValue.base64ToImage()
        
        self.arrImage.append(self.front_image_base64!)
        self.arrImage.append(self.left_image_base64!)
        self.arrImage.append(self.right_image_base64!)
        self.arrImage.append(self.back_image_base64!)
    }
    
    static func LoadProductByID(ProID: Int, completion: @escaping (DetailViewModel) -> ()){
        var data = DetailViewModel()
        let dispatchGroup = DispatchGroup()
        let headers: HTTPHeaders = [
            "Cookie": "",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization" : User.getUserEncoded(),
        ]
        
        dispatchGroup.enter()
        Alamofire.request(PROJECT_API.LOADPRODUCT(ProID: ProID), method: .get,encoding: JSONEncoding.default,
                          headers: headers ).responseJSON
            { response in
                switch response.result{
                case .success (let value):
                    let json = JSON(value)
                    data = DetailViewModel(json: json)
                    
                    dispatchGroup.enter()
                    Converts.getYearbyID(id: data.year, completion: { (val) in
                        data.getYear = val
                        dispatchGroup.leave()
                    })
                    
                    dispatchGroup.enter()
                    Converts.getBrandbyModeID(id: data.modeling, completion: { (val) in
                        data.getBrand = val
                        dispatchGroup.leave()
                    })
                    
                    dispatchGroup.enter()
                    Converts.getTypebyID(id: data.type, completion: { (val) in
                        data.getType = val
                        dispatchGroup.leave()
                    })
                    
                    dispatchGroup.enter()
                    Converts.getModelbyID(id: data.modeling, completion: { (val) in
                        data.getModel = val
                        dispatchGroup.leave()
                    })
                    
                    
                    dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                }
        }

        dispatchGroup.notify(queue: .main) {
            completion(data)
        }
    }
    
    static func LoadProductByIDOfUser(ProID: Int, completion: @escaping (DetailViewModel) -> ()){
        var data = DetailViewModel()
        let dispatchGroup = DispatchGroup()
        let headers: HTTPHeaders = [
            "Cookie": "",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization" : User.getUserEncoded(),
        ]
        
        dispatchGroup.enter()
        Alamofire.request(PROJECT_API.LOADPRODUCTOFUSER(ProID: ProID), method: .get,encoding: JSONEncoding.default,
                          headers: headers ).responseJSON
            { response in
                switch response.result{
                case .success (let value):
                    let json = JSON(value)
                    data = DetailViewModel(json: json)
                    
                    dispatchGroup.enter()
                    Converts.getYearbyID(id: data.year, completion: { (val) in
                        data.getYear = val
                        dispatchGroup.leave()
                    })
                    
                    dispatchGroup.enter()
                    Converts.getBrandbyModeID(id: data.modeling, completion: { (val) in
                        data.getBrand = val
                        dispatchGroup.leave()
                    })
                    
                    dispatchGroup.enter()
                    Converts.getTypebyID(id: data.type, completion: { (val) in
                        data.getType = val
                        dispatchGroup.leave()
                    })
                    
                    dispatchGroup.enter()
                    Converts.getModelbyID(id: data.modeling, completion: { (val) in
                        data.getModel = val
                        dispatchGroup.leave()
                    })
                    
                    
                    dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(data)
        }
    }
}
