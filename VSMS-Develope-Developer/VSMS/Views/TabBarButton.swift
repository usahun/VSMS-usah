//
//  TabBarButton.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/10/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class TabBarButton: UIView {

    @IBOutlet private var content: UIView!
    @IBOutlet private weak var Home: UIImageView!
    @IBOutlet private weak var Notification: UIImageView!
    @IBOutlet private weak var Camera: UIImageView!
    @IBOutlet private weak var Chat: UIImageView!
    @IBOutlet private weak var Profile: UIImageView!
    
    @IBOutlet private weak var lblHome: UILabel!
    @IBOutlet private weak var lblNotification: UILabel!
    @IBOutlet private weak var lblCamera: UILabel!
    @IBOutlet private weak var lblChat: UILabel!
    @IBOutlet private weak var lblProfile: UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup()
    {
        Bundle.main.loadNibNamed("TabBarButton", owner: self, options: nil)
        
        content.frame = self.bounds
        self.addSubview(content)
    }
}

