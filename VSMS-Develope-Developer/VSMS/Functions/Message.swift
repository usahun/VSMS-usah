//
//  Message.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/11/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import UIKit


var paginationRecord: Int = 5

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
    
    public static func ConfirmDeleteMessage(message: String, callback:@escaping (() -> Void)){
        let AlertMessage = UIAlertController(title: "Delete",
                                             message: message,
                                             preferredStyle: .alert)
        AlertMessage.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
            callback()
        }))
        AlertMessage.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        let view = UIApplication.topViewController()
        view!.present(AlertMessage, animated: true, completion: nil)
    }
    
    public static func AlertMessage(message: String, header: String, View: UIViewController, callback:@escaping (() -> Void)){
        let AlertMessage = UIAlertController(title: header,
                                             message: message,
                                             preferredStyle: .alert)
        AlertMessage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        AlertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            callback()
        }))
        
        View.present(AlertMessage, animated: true, completion: nil)
    }
    
    static func AlertLogOutMessage(from: UIViewController, completion: @escaping () -> Void)
    {
        let alertCon = UIAlertController(title: "Edit Profile", message: nil, preferredStyle: .actionSheet)
        alertCon.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (alert) in
            completion()
        }))
        alertCon.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        from.present(alertCon, animated: true, completion: nil)
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


func showToast(message : String, view: UIViewController) {
    
    let toastLabel = UILabel(frame: CGRect(x: view.view.frame.size.width/2 - 75, y: view.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    view.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}


