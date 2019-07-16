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
    
    public static func AlertMessage(message: String, header: String, View: UIViewController, callback:@escaping (() -> Void)){
        let AlertMessage = UIAlertController(title: header,
                                             message: message,
                                             preferredStyle: .alert)
        AlertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            callback()
        }))
        View.present(AlertMessage, animated: true, completion: nil)
    }
    
}


class UIViewBorderButtom: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: frame.minX, y: frame.height, width: frame.width, height: 0.5);
        layer.addSublayer(border)
    }
}


class BottomDetail: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
    }
}


public enum QueueType {
    case Main
    case Background
    case LowPriority
    case HighPriority
    
    var queue: DispatchQueue {
        switch self {
        case .Main:
            return DispatchQueue.main
        case .Background:
            return DispatchQueue(label: "com.app.queue",
                                 qos: .background,
                                 target: nil)
        case .LowPriority:
            return DispatchQueue.global(qos: .userInitiated)
        case .HighPriority:
            return DispatchQueue.global(qos: .userInitiated)
        }
    }
}

func performOn(_ queueType: QueueType, closure: @escaping () -> Void) {
    queueType.queue.async(execute: closure)
}
