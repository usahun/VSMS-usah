//
//  Stock Transfer.swift
//  VSMS
//
//  Created by usah on 3/24/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import UIKit

enum StoreProcess: Int {
    case banlance
    case post
}

protocol StoreProcessDelegate: class {
    func callbackType(_ with: [String], type: StoreProcess)
}

class StockTranfer : UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    //Prperties
    
    @IBOutlet weak var coverPicture: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var tableContent: UITableView!
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    //Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableContent.delegate = self
        tableContent.dataSource = self
        configNavigation()
    }
    
    @IBAction func editProfileclick(_ sender: Any) {
        print("Edit Profile")
    }
    @IBAction func shareClick(_ sender: Any) {
        print("Share Click")
    }
    
    @IBAction func settingClick(_ sender: Any) {
        print("Setting Click")
    }
    

    
    ///functions
    
    func configNavigation(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "opacity50"), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    ///////Overide Method Table
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        return cell
    }
    
    
}













