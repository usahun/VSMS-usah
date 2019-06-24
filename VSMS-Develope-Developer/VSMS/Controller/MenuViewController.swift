//
//  MenuViewController.swift
//  VSMS
//
//  Created by usah on 6/4/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class SectionMenu: UITableViewCell{
    
    @IBOutlet weak var content: UILabel!
    
}

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
   
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.layer.cornerRadius = img.frame.width * 0.5
        img.clipsToBounds = true
        
        

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SectionMenu
        
        let row = indexPath.row
        if row == 0 {
            cell.content.text? = "Your  Profile"
        }else if row == 1{
            cell.content.text? = "Your  Posts"
        }else if row == 2{
            cell.content.text? = "Your  Like"
        }else if row == 3{
            cell.content.text? = "Your  Loan"
        }else if row == 4{
            cell.content.text? = "Sing Out"
        }else if row == 5{
            cell.content.text? = "About Us"
        }else if row == 6{
            cell.content.text? = "Term of Privacy"
        }
        return cell
    }

}


