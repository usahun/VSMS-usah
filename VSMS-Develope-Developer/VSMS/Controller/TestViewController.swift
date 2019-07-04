//
//  TestViewController.swift
//  VSMS
//
//  Created by usah on 3/10/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mysegmentControl: UISegmentedControl!
    
    var post = ["Test","Test2"]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.delegate = self
       tableView.dataSource = self
       
        
        let posts = UINib(nibName: "PostsTableViewCell", bundle: nil)
        tableView.register(posts, forCellReuseIdentifier: "Postcell")
        
        let likes = UINib(nibName: "LikesTableViewCell", bundle: nil)
        tableView.register(likes, forCellReuseIdentifier: "likesCell")
        
    }
    
    
    
    @IBAction func swicthChange(_ sender: UISegmentedControl) {
        
        index = mysegmentControl.selectedSegmentIndex
        tableView.reloadData()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
            return cell
        }else {
       let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell", for: indexPath) as! LikesTableViewCell
        return cell
        }
    }
    
    
    
}
