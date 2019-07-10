//
//  Protocol.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/3/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol XibtoXib {
    func getDropDownID(Id: String)
}

protocol refreshDropdownInXib: class {
    func refreshXib(FKKey: Int)
}

protocol RecordCountProtocol: class {
    func getRecCount(recordCount: Int)
}

class CellClickViewModel {
    var ID: String = ""
    var Value: String = ""
    var IndexPathKey: NSIndexPath? = nil
}

struct dropdownData {
    var ID: String
    var Text: String
    var FKKey: String?
    
    init(json: JSON) {
        self.ID = json["id"].stringValue
        self.Text = json["Text"].stringValue
        self.FKKey = json["FKKey"].string
    }
    
    init(ID: String, Text: String, FKKey: String? ) {
        self.ID = ID
        self.Text = Text
        self.FKKey = FKKey
    }
}
