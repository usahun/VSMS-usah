//
//  AboutUsandTermofprivancyTableViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/11/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class AboutUsandTermofprivancyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        XibRegister()
       
    }
    
    func XibRegister(){
        tableView.register(UINib(nibName: "AboutUsTableViewCell",bundle: nil), forCellReuseIdentifier: "AboutUs")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUs", for: indexPath) as! AboutUsTableViewCell
        cell.txtaboutus.delegate = self
        return cell
    }

   
}
