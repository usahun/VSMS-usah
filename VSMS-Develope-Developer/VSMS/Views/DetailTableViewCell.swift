//
//  DetailTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/8/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import DropDown

class DetailTableViewCell: UITableViewCell, refreshDropdownInXib, UITextViewDelegate {

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
    @IBOutlet weak var txtDescription: UITextView!
    
    //Internal Properties
    weak var delegate: CellTableClick?
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

    //Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        initailDropDownData()
    }
    
    func refreshXib(FKKey: Int) {
        btnModel.setTitle("", for: .normal)
        passingData.ID = ""
        passingData.Value = ""
        self.delegate?.ClickCell(currentCell: passingData)
        
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
    
    //Functions and Selectors
    @IBAction func btnPostTypeClick(_ sender: UIButton) {
        PostTypeDropdown.show()
    }
    @IBAction func TitleChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.ClickCell(currentCell: passingData)
    }
    @IBAction func CategoryClick(_ sender: UIButton) {
        CategoryDropdown.show()
    }
    @IBAction func TypeClick(_ sender: UIButton) {
        TypeDropdown.show()
    }
    @IBAction func BrandClick(_ sender: UIButton) {
        BrandDropdown.show()
    }
    @IBAction func ModelClick(_ sender: UIButton) {
        ModelDropdown.show()
    }
    
    @IBAction func YearClick(_ sender: UIButton) {
        YearDropdown.show()

    }
    @IBAction func ConditionClick(_ sender: UIButton) {
        ConditionDropdown.show()
    }
    @IBAction func ColorClick(_ sender: UIButton) {
        ColorDropdown.show()
    }
    @IBAction func VinCodeChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.ClickCell(currentCell: passingData)
    }
    @IBAction func MachineCodeChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.ClickCell(currentCell: passingData)
    }
 
    func textViewDidChange(_ textView: UITextView) {
        print("I have edit text View.")
    }
    
    @IBAction func PriceChange(_ sender: UITextField) {
        passingData.ID = sender.text ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.ClickCell(currentCell: passingData)
    }

    
    //Configuration methods
    
    func setupPostTypeDropDown() {
        PostTypeDropdown.anchorView = btnPostType
        PostTypeDropdown.dataSource = dropdownData
        // Action triggered on selection
        PostTypeDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnPostType.setTitle(item, for: .normal)
            self!.PostTypeDropdown.hide()
        }
    }
    
    func setupCategoryDropDown(){
        CategoryDropdown.anchorView = btnCategory
        CategoryDropdown.dataSource = dropdownData
        // Action triggered on selection
        CategoryDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnCategory.setTitle(item, for: .normal)
            self!.CategoryDropdown.hide()
        }
    }
    
    func setupTypeDropDown(){
        TypeDropdown.anchorView = btnType
        TypeDropdown.dataSource = dropdownData
        // Action triggered on selection
        TypeDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnType.setTitle(item, for: .normal)
            self!.TypeDropdown.hide()
        }
    }
    
    func setupBrandDropDown(){
        BrandDropdown.anchorView = btnBrand
        BrandDropdown.dataSource = dropdownData
        // Action triggered on selection
        BrandDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnBrand.setTitle(item, for: .normal)
            self!.BrandDropdown.hide()
        }
    }
    
    func setupModelDropDown(){
        ModelDropdown.anchorView = btnModel
        ModelDropdown.dataSource = dropdownData
        // Action triggered on selection
        ModelDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnModel.setTitle(item, for: .normal)
            self!.ModelDropdown.hide()
        }
    }
    
    func setupYearDropDown(){
        YearDropdown.anchorView = btnYear
        YearDropdown.dataSource = dropdownData
        // Action triggered on selection
        YearDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnYear.setTitle(item, for: .normal)
            self!.YearDropdown.hide()
        }
    }
    
    func setupConditionDropDown(){
        ConditionDropdown.anchorView = btnCodition
        ConditionDropdown.dataSource = dropdownData
        // Action triggered on selection
        ConditionDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnCodition.setTitle(item, for: .normal)
            self!.ConditionDropdown.hide()
        }
    }
    
    func setupColorDropDown(){
        ColorDropdown.anchorView = btnColor
        ColorDropdown.dataSource = dropdownData
        // Action triggered on selection
        ColorDropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = self?.rawValue[index].ID ?? ""
            self?.passingData.Value = self?.rawValue[index].Text ?? ""
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnColor.setTitle(item, for: .normal)
            self!.ColorDropdown.hide()
        }
    }
    
    
    func initailDropDownData(){
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
            case 11:
                self.txtDescription.delegate = self
            default:
                print("OK")
            }
        }
        
        
    }
    
}
