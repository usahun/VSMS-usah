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
    
    func base64ToImage() -> UIImage?{
        let imageData = NSData(base64Encoded: self ,options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        return UIImage(data: imageData! as Data) ?? UIImage()
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return ""
        
    }
    
    func formationDate() -> String{
        
        if self == "" {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "Asia/Tehran") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss" ; //"dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale --> but no need here
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }
    
    func getDuration() -> String{
        let startDate = self.formationDate()
        
        if startDate == "" {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let formatedStartDate = dateFormatter.date(from: startDate)
        let currentDate = Date()
        let components = Set<Calendar.Component>([.minute, .hour, .day, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
        
        print (differenceOfDate)
        if differenceOfDate.year! > 0 {
            return "\(differenceOfDate.year ?? 1) year\(differenceOfDate.year! > 1 ? "s" : "")"
        }
        if differenceOfDate.month! > 0 {
            return "\(differenceOfDate.month!) month ago"
        }
        if differenceOfDate.day! > 0 {
            return "\(differenceOfDate.day!) day ago"
        }
        if differenceOfDate.hour! > 0 {
            return "\(differenceOfDate.hour!) hour ago"
        }
        if differenceOfDate.minute! > 0 {
            return "\(differenceOfDate.minute!) minute ago"
        }
        else {
            return "a minute ago"
        }
    }
    
    func toDouble() -> Double {
        if let double = Double(self) {
            return double
        }
        else {
            return 0
        }
    }
    
    func toCurrency() -> String {
        let myDouble = self.toDouble()
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        
        let priceString = currencyFormatter.string(from: NSNumber(value: myDouble))!
        return priceString
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
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

extension UIImageView {
    func CirleWithWhiteBorder(thickness: CGFloat){
        self.layer.cornerRadius = self.layer.frame.width / 2
        self.clipsToBounds = true
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = thickness
    }
    
    func Inputchecked(){
        self.image = #imageLiteral(resourceName: "check_mark")
    }
    
    func InputCrossed(){
        self.image = #imageLiteral(resourceName: "cross_mark")
    }
    
}

extension UITextField {
    
    func bordercolor(){
        let myColor = UIColor(red: CGFloat(92/255.0), green: CGFloat(203/255.0),
                              blue: CGFloat(207/255.0), alpha: CGFloat(1.0))
        
        self.layer.borderColor = myColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
    
}

extension Collection {
    func get(at index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}


extension UIView {
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
}


extension UINavigationBar {
    func installBlurEffect() {
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .default)
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        var blurFrame = bounds
        blurFrame.size.height += statusBarHeight
        blurFrame.origin.y -= statusBarHeight
        let blurView  = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.isUserInteractionEnabled = false
        blurView.frame = blurFrame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        blurView.layer.zPosition = -1
    }
}


extension Collection {
    
    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
    
}

extension UISearchBar {
    func enable() {
        isUserInteractionEnabled = true
        alpha = 1.0
    }
    
    func disable() {
        isUserInteractionEnabled = false
        alpha = 0.5
    }
}


extension UIViewController {
    func PushToDetailProductViewController(productID: Int){
        DetailViewModel.LoadProductByID(ProID: productID) { (val) in
            self.hidesBottomBarWhenPushed = true
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                viewController.ProductDetail = val
                viewController.tabBarController?.tabBar.isHidden = true
                self.navigationController?.pushViewController(viewController, animated: true)
                self.hidesBottomBarWhenPushed = false
            }
        }
    }
    
    func PushToDetailProductByUserViewController(productID: Int){
        DetailViewModel.LoadProductByIDOfUser(ProID: productID) { (val) in
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                viewController.ProductDetail = val
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func PushToLogInViewController(){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as? LoginController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func PushToEditPostViewController(ID: Int)
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostAdViewController") as? PostAdViewController {
//            performOn(.Main) {
//                viewController.JsonData = PostViewModel(ID: ID)
//            }
            viewController.PostIDEdit = ID
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension UITableViewCell {
    func PustToDetailProductViewController(ProID: Int)
    {
        DetailViewModel.LoadProductByIDOfUser(ProID: ProID) { (val) in
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                viewController.ProductDetail = val
                self.window?.rootViewController?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}


extension UIViewController {
    var top: UIViewController? {
        if let controller = self as? UINavigationController {
            return controller.topViewController?.top
        }
        if let controller = self as? UISplitViewController {
            return controller.viewControllers.last?.top
        }
        if let controller = self as? UITabBarController {
            return controller.selectedViewController?.top
        }
        if let controller = presentedViewController {
            return controller.top
        }
        return self
    }
    
    func ShowDefaultNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.254701972, green: 0.5019594431, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func HasTabNoNav(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func HasNavNoTab(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}


extension UIAlertController {
    
    private struct ActivityIndicatorData {
        static var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    }
    
    func addActivityIndicator() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 40,height: 20)
        ActivityIndicatorData.activityIndicator.color = UIColor.blue
        ActivityIndicatorData.activityIndicator.startAnimating()
        vc.view.addSubview(ActivityIndicatorData.activityIndicator)
        self.setValue(vc, forKey: "contentViewController")
    }
    
    func dismissActivityIndicator() {
        ActivityIndicatorData.activityIndicator.stopAnimating()
        self.dismiss(animated: false)
    }
}



