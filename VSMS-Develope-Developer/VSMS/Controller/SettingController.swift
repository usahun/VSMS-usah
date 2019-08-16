//
//  SettingController.swift
//  VSMS
//
//  Created by usah on 3/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

    
class SettingTableController: UITableViewController
{
    
    @IBOutlet weak var btnLogOut: BottomDetail!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LogOutHandle(_ sender: UIButton) {
        Message.AlertLogOutMessage(from: self) {
            User.resetUserDefault()
            PresentController.HomePage()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
