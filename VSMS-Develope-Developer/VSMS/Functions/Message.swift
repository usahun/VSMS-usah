//
//  Message.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/11/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import UIKit

class Message {
    
    public static func ErrorMessage(message: String, View: UIViewController) {
        let AlertMessage = UIAlertController(title: "Error",
                                             message: message,
                                             preferredStyle: .alert)
        AlertMessage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        View.present(AlertMessage, animated: true, completion: nil)
    }
    
    public static func SuccessMessage(message: String, View: UIViewController, callback:@escaping (() -> Void)){
        let AlertMessage = UIAlertController(title: "Successfully",
                                             message: message,
                                             preferredStyle: .alert)
        AlertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            callback()
        }))
        View.present(AlertMessage, animated: true, completion: nil)
    }
    
}
