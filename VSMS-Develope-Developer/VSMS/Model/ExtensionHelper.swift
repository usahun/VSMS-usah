//
//  ExtensionHelper.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/9/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation



extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func toDataEncodingUTF8() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
}

extension Int {
    func toString() -> String {
        return "\(self)"
    }
    
    func toDataEncodingUTF8() -> Data {
        return self.toString().data(using: String.Encoding.utf8)!
    }
}


extension UIImage {
    func toBase64() -> String {
        guard let imageData = self.pngData() else { return "" }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters) 
    }
}


extension Collection {
    func get(at index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
