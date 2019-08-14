//
//  StructTemplate.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/14/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import RSSelectionMenu


struct DropDownTemplate: Codable, UniquePropertyDelegate {
    
    let ID: String?
    let Text: String?
    let Fkey: String?
    
    func getUniquePropertyName() -> String {
        return "ID"
    }
}
