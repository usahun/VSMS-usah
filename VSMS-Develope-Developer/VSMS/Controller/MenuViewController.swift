//
//  MenuViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/24/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SideMenuSwift
class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: leftMenuClick?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageprofile.layer.cornerRadius = imageprofile.frame.width * 0.5
        imageprofile.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        lblProfileName.text = User.getUsername()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.delegate?.cellClick(list: "profile")
        case 1:
            self.delegate?.cellClick(list: "post")
        case 2:
            self.delegate?.cellClick(list: "like")
        case 3:
            break
            //self.delegate?.cellClick(list: "share")
        case 4:
            self.delegate?.cellClick(list: "loan")
        default:
            break
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SectionMenu
        let row = indexPath.row
        
        if row == 0{
            cell.titleLabel.text = " Your Profile"
        } else if row == 1 {
            cell.titleLabel.text = " Your Posts "
        } else if row == 2 {
            cell.titleLabel.text = " Your Likes "
        } else if row == 3 {
            cell.titleLabel.text = " Your Shares "
        } else if row == 4 {
            cell.titleLabel.text = " Your Loans "
        } else if row == 5 {
            cell.titleLabel.text = " Setting "
        } else if row == 6 {
            cell.titleLabel.text = " About Us "
        } else if row == 7 {
            cell.titleLabel.text = " Term Privacy "
        }
        return cell
    }
    
    
    
}

class SectionMenu: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
}
