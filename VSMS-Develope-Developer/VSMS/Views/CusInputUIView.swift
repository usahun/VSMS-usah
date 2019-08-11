//
//  CusInputUIView.swift
//  VSMS
//
//  Created by Rathana on 8/9/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class CusInputUIView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var imgValidate: UIImageView!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    @IBInspectable var placeHolder: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    private func setupXib()
    {
        Bundle.main.loadNibNamed("CusInputUIView", owner: self, options: nil)
        contentView.frame = self.bounds
        self.addSubview(contentView)
        
        configXib()
    }
    
    private func configXib()
    {
        txtInput.placeholder = self.placeHolder
    }
}
