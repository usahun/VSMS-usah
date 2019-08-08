//
//  LoanViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/8/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoanViewController: UITableViewController {

    
    @IBOutlet weak var txtJob: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Configuration
    func Configuration()
    {
        self.navigationItem.title = "Loan Information"
        self.navigationItem.leftBarButtonItem?.title = "Cancel"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
