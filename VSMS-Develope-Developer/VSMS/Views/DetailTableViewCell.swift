//
//  DetailTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/8/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import DropDown

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var btnPostType: UIButton!
    @IBOutlet weak var txttitle: UITextField!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var btnBrand: UIButton!
    @IBOutlet weak var btnModel: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnCodition: UIButton!
    @IBOutlet weak var btnColor: UIButton!
    @IBOutlet weak var txtVinCode: UITextField!
    @IBOutlet weak var txtMachineCode: UITextField!
    @IBOutlet weak var btnPrice: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var postTypeCheck: UIImageView!
    @IBOutlet weak var titleCheck: UIImageView!
    @IBOutlet weak var categoryCheck: UIImageView!
    @IBOutlet weak var typeCheck: UIImageView!
    @IBOutlet weak var brandCheck: UIImageView!
    @IBOutlet weak var modelCheck: UIImageView!
    @IBOutlet weak var yearCheck: UIImageView!
    @IBOutlet weak var conditionCheck: UIImageView!
    @IBOutlet weak var colorCheck: UIImageView!
    @IBOutlet weak var desCheck: UIImageView!
    @IBOutlet weak var priceCheck: UIImageView!
    
    
    //Internal Properties
    weak var delegate: getValueFromXibDetail?
    var passingData = CellClickViewModel()
    var PostTypeDropdown = DropDown()
    var CategoryDropdown = DropDown()
    var TypeDropdown = DropDown()
    var BrandDropdown = DropDown()
    var ModelDropdown = DropDown()
    var YearDropdown = DropDown()
    var ConditionDropdown = DropDown()
    var ColorDropdown = DropDown()
    var rawValue: [dropdownData] = []
    var dropdownData: [String] = []
    var BrandChangeHandle: ((String) -> Void)?

    //Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HandlClick)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        initailDropDownData()
    }
    
    @objc
    func HandlClick(){
        switch passingData.IndexPathKey?.row {
        case 0:
            PostTypeDropdown.show()
        case 2:
            CategoryDropdown.show()
        case 3:
            TypeDropdown.show()
        case 4:
            BrandDropdown.show()
        case 5:
            ModelDropdown.show()
        case 6:
            YearDropdown.show()
        case 7:
            ConditionDropdown.show()
        case 8:
            ColorDropdown.show()
        default:
            break
        }
    }
    
    
    
    func refreshXib(FKKey: Int) {
        btnModel.setTitle("", for: .normal)
        passingData.ID = ""
        passingData.Value = ""
        self.delegate?.getModel(value: passingData)
        Functions.getDropDownList(key: passingData.IndexPathKey!.row) { (val) in
            self.rawValue = val.filter({$0.FKKey == FKKey.toString()})
            self.dropdownData = []
            self.dropdownData = val.filter({$0.FKKey == FKKey.toString()}).map({$0.Text})
            self.setupModelDropDown()
        }
    }
    
    func getDiscountTypeValue(disType: String) {
        print("")
    }
    
    @IBAction func TitleChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.getTitle(value: passingData)
        
        if sender.text!.count <= 3 {
            titleCheck.image = #imageLiteral(resourceName: "icons8-cancel-48")
        }
        else{
            titleCheck.image = #imageLiteral(resourceName: "check_mark")
        }
    }

    @IBAction func VinCodeChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.getVinCode(value: passingData)
    }
    @IBAction func MachineCodeChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.getMachinecode(value: passingData)
    }
    
    @IBAction func PriceChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.getPrice(value: passingData)
            if sender.text!.count > 0 {
                self.priceCheck.image = #imageLiteral(resourceName: "check_mark")
            }
            else {
                self.priceCheck.image = #imageLiteral(resourceName: "cross_mark")
            }
        
    }
    

    
    //Configuration methods
    
    func setupPostTypeDropDown() {
        PostTypeDropdown.anchorView = btnPostType
        PostTypeDropdown.dataSource = dropdownData
        PostTypeDropdown.width = self.frame.width
        // Action triggered on selection
        PostTypeDropdown.selectionAction = { [weak self] (index, item) in
            self!.postTypeCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getPostType(value: self!.passingData)
            self?.btnPostType.setTitle(item, for: .normal)
            self!.PostTypeDropdown.hide()
        }
    }
    
    func setupCategoryDropDown(){
        CategoryDropdown.anchorView = btnCategory
        CategoryDropdown.dataSource = dropdownData
        CategoryDropdown.width = self.frame.width
        // Action triggered on selection
        CategoryDropdown.selectionAction = { [weak self] (index, item) in
            self!.categoryCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getCategory(value: self!.passingData)
            self?.btnCategory.setTitle(item, for: .normal)
            self!.CategoryDropdown.hide()
        }
    }
    
    func setupTypeDropDown(){
        TypeDropdown.anchorView = btnType
        TypeDropdown.dataSource = dropdownData
        TypeDropdown.width = self.frame.width
        // Action triggered on selection
        TypeDropdown.selectionAction = { [weak self] (index, item) in
            self!.typeCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getType(value: self!.passingData)
            self?.btnType.setTitle(item, for: .normal)
            self!.TypeDropdown.hide()
        }
    }
    
    func setupBrandDropDown(){
        BrandDropdown.anchorView = btnBrand
        BrandDropdown.dataSource = dropdownData
        BrandDropdown.width = self.frame.width
        // Action triggered on selection
        BrandDropdown.selectionAction = { [weak self] (index, item) in
            self!.brandCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getBrand(value: self!.passingData)
            self?.btnBrand.setTitle(item, for: .normal)
            self!.BrandDropdown.hide()
            print("BrandClick")
            self?.BrandChangeHandle?(self?.passingData.ID ?? "")
        }
    }
    
    func setupModelDropDown(){
        ModelDropdown.anchorView = btnModel
        ModelDropdown.dataSource = dropdownData
        ModelDropdown.width = self.frame.width
        // Action triggered on selection
        ModelDropdown.selectionAction = { [weak self] (index, item) in
            self!.modelCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getModel(value: self!.passingData)
            self?.btnModel.setTitle(item, for: .normal)
            self!.ModelDropdown.hide()
        }
    }
    
    func setupYearDropDown(){
        YearDropdown.anchorView = btnYear
        YearDropdown.dataSource = dropdownData
        YearDropdown.width = self.frame.width
        // Action triggered on selection
        YearDropdown.selectionAction = { [weak self] (index, item) in
            self!.yearCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getYear(value: self!.passingData)
            self?.btnYear.setTitle(item, for: .normal)
            self!.YearDropdown.hide()
        }
    }
    
    func setupConditionDropDown(){
        ConditionDropdown.anchorView = btnCodition
        ConditionDropdown.dataSource = dropdownData
        ConditionDropdown.width = self.frame.width
        // Action triggered on selection
        ConditionDropdown.selectionAction = { [weak self] (index, item) in
            self!.conditionCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getCondition(value: self!.passingData)
            self?.btnCodition.setTitle(item, for: .normal)
            self!.ConditionDropdown.hide()
        }
    }
    
    func setupColorDropDown(){
        ColorDropdown.anchorView = btnColor
        ColorDropdown.dataSource = dropdownData
        ColorDropdown.width = self.frame.width
        // Action triggered on selection
        ColorDropdown.selectionAction = { [weak self] (index, item) in
            self!.colorCheck.image = #imageLiteral(resourceName: "check_mark")
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.getColor(value: self!.passingData)
            self?.btnColor.setTitle(item, for: .normal)
            self!.ColorDropdown.hide()
        }
    }
    
    
    func initailDropDownData(){
        if passingData.IndexPathKey!.row == 9 {
            textView.delegate = self
        }
        
        Functions.getDropDownList(key: self.passingData.IndexPathKey!.row) { (value) in
            self.rawValue = value
            self.dropdownData = value.map{
                $0.Text
            }
            
            switch self.passingData.IndexPathKey?.row {
            case 0:
                self.setupPostTypeDropDown()
            case 2:
                self.setupCategoryDropDown()
            case 3:
                self.setupTypeDropDown()
            case 4:
                self.setupBrandDropDown()
            case 5:
                self.setupModelDropDown()
            case 6:
                self.setupYearDropDown()
            case 7:
                self.setupConditionDropDown()
            case 8:
                self.setupColorDropDown()
            case 9:
                self.textView.delegate = self
            default:
                print("OK")
            }
        }
        
        
    }
    
}

extension DetailTableViewCell: getDropdowntypeProtocol {
    func getDropDownTypeData(type: String) {
        self.refreshXib(FKKey: type.toInt())
    }
}

extension DetailTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count > 3 {
            desCheck.image = #imageLiteral(resourceName: "check_mark")
        }
        else {
            desCheck.image = #imageLiteral(resourceName: "icons8-cancel-48")
        }
        
        passingData.ID = textView.text
        passingData.Value = textView.text
        self.delegate?.getDescription(value: passingData)
    }
}
