//
//  PostViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/14/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import RSSelectionMenu


class PostViewController: UITableViewController {
    
    ///Detail
    @IBOutlet weak var postType: CusDropDownUIView!
    @IBOutlet weak var txtTitle: CusInputUIView!
    @IBOutlet weak var cboCategory: CusDropDownUIView!
    @IBOutlet weak var cboType: CusDropDownUIView!
    @IBOutlet weak var cboBrand: CusDropDownUIView!
    @IBOutlet weak var cboModel: CusDropDownUIView!
    @IBOutlet weak var cboYear: CusDropDownUIView!
    @IBOutlet weak var cboCondition: CusDropDownUIView!
    @IBOutlet weak var cboColor: CusDropDownUIView!
    @IBOutlet weak var txtDescription: CusTextAreaInput!
    @IBOutlet weak var txtPrice: CusInputUIView!
    //Discount
    @IBOutlet weak var cboDiscountType: CusDropDownUIView!
    @IBOutlet weak var txtDiscountAmount: CusInputUIView!
    //Contact
    @IBOutlet weak var txtName: CusInputUIView!
    @IBOutlet weak var txtPhoneNumber: CusInputUIView!
    @IBOutlet weak var txtEmail: CusInputUIView!
    //submit
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    /////
    var post_arr = [DropDownTemplate]()
    var category_arr = [DropDownTemplate]()
    var type_arr = [DropDownTemplate]()
    var brand_arr = [DropDownTemplate]()
    var model_arr = [DropDownTemplate]()
    var year_arr = [DropDownTemplate]()
    var condition_arr = [DropDownTemplate]()
    var color_arr = [DropDownTemplate]()
    var discount_type_arr = [DropDownTemplate]()
    
    /////selected arr
    var post_selected = [DropDownTemplate]()
    var category_selected = [DropDownTemplate]()
    var type_selected = [DropDownTemplate]()
    var brand_selected = [DropDownTemplate]()
    var model_selected = [DropDownTemplate]()
    var year_selected = [DropDownTemplate]()
    var condition_selected = [DropDownTemplate]()
    var color_selected = [DropDownTemplate]()
    var discount_type_selected = [DropDownTemplate]()
    
    //Internal Properties
    var post_obj = PostAdViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Post Ad"
        
        ShowDefaultNavigation()
        Prepare()
    }

    // MARK: - Table view data source
    
    @IBAction func SubmitHandler(_ sender: UIButton) {
        post_obj.title = txtTitle.Value
        post_obj.cost = txtPrice.Value
        post_obj.description = txtDescription.Value
        post_obj.discount = txtDiscountAmount.Value == "" ? "0": txtDiscountAmount.Value
        post_obj.name = txtName.Value
        post_obj.contact_phone = txtPhoneNumber.Value
        post_obj.contact_email = txtEmail.Value
        
        post_obj.front_image_path = UIImage(named: "Dream191")?.toBase64()
        post_obj.left_image_path = post_obj.front_image_path
        post_obj.right_image_path = post_obj.front_image_path
        post_obj.back_image_path = post_obj.front_image_path
        
        post_obj.front_image_base64 = post_obj.front_image_path
        post_obj.left_image_base64 = post_obj.front_image_path
        post_obj.right_image_base64 = post_obj.front_image_path
        post_obj.back_image_base64 = post_obj.front_image_path
        
        
        post_obj.Save { (result) in
            
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 && isBuy()
        {
            return UIView()
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
            return CGFloat.leastNonzeroMagnitude
        }
        if section == 2 && isBuy()
        {
            return CGFloat.leastNonzeroMagnitude
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeightbyIndexPath(indexpath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 11
        case 2:
            if isBuy() {
                return 0
            }
            return 2
        case 3:
            return 3
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            switch indexPath.row
            {
            case 0:
                self.ShowPostTypeOption(style: .push)
            case 2:
                self.ShowCategoryOption(style: .push)
            case 3:
                self.ShowTypeOption(style: .push)
            case 4:
                self.ShowBrandOption(style: .push)
            case 5:
                self.ShowModelOption(style: .push)
            case 6:
                self.ShowYearOption(style: .push)
            case 7:
                self.ShowConditionOption(style: .push)
            case 8:
                self.ShowColorOption(style: .push)
            default:
                break
            }
        }
        if indexPath.section == 2 && indexPath.row == 0
        {
            self.ShowDiscountTypeOption(style: .push)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension PostViewController {
    func Prepare()
    {
        self.txtName.Value = User.getUsername()
        //self.txtPhoneNumber.Value = User.getUsername()
        
        self.post_arr = GenerateList.getPostType()
        self.color_arr = GenerateList.getColor()
        self.discount_type_arr = GenerateList.getDiscountType()
        self.condition_arr = GenerateList.getCondition()
        
        GenerateList.getCategory { (val) in
            self.category_arr = val
        }
        
        GenerateList.getType { (val) in
            self.type_arr = val
        }
        
        GenerateList.getBrand { (val) in
            self.brand_arr = val
        }
        
        GenerateList.getModel { (val) in
            self.model_arr = val
        }
        
        GenerateList.getYear { (val) in
            self.year_arr = val
        }
    }
    
    func ShowPostTypeOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: post_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: post_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.post_selected = selectedItems
            self?.postType.Value = text!.Text!
            self?.post_obj.post_type = (text?.ID)!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Post Type"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowCategoryOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: category_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: category_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.category_selected = selectedItems
            self?.cboCategory.Value = text!.Text!
            self?.post_obj.category = (text?.ID?.toInt())!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Category"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowTypeOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: type_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: type_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.type_selected = selectedItems
            self?.cboType.Value = text!.Text!
            self?.post_obj.type = (text?.ID?.toInt())!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Type"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowBrandOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: brand_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: brand_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.brand_selected = selectedItems
            self?.cboBrand.Value = text!.Text!
            self?.post_obj.brand = (text?.ID?.toInt())!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Brand"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowModelOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: model_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: model_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.model_selected = selectedItems
            self?.cboModel.Value = text!.Text!
            self?.post_obj.modeling = (text?.ID?.toInt())!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Model"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowYearOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: year_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: year_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.year_selected = selectedItems
            self?.cboYear.Value = text!.Text!
            self?.post_obj.year = (text?.ID?.toInt())!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Year"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowConditionOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: condition_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: condition_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.condition_selected = selectedItems
            self?.cboCondition.Value = text!.Text!
            self?.post_obj.condition = (text?.ID)!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Condition"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowColorOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: color_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: color_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.color_selected = selectedItems
            self?.cboColor.Value = text!.Text!
            self?.post_obj.color = (text?.ID)!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Color"
        selectionMenu.show(style: style, from: self)
    }
    
    func ShowDiscountTypeOption(style: PresentationStyle)
    {
        let selectionMenu = RSSelectionMenu(dataSource: discount_type_arr)
        { (cell, item, indexPath) in
            cell.textLabel?.text = item.Text
        }
        
        selectionMenu.setSelectedItems(items: discount_type_selected)
        { [weak self] (text, index, isSelected, selectedItems) in
            self?.discount_type_selected = selectedItems
            self?.cboDiscountType.Value = text!.Text!
            self?.post_obj.discount_type = (text?.ID)!
            self?.tableView.reloadData()
        }
        selectionMenu.navigationItem.title = "Discount Type"
        selectionMenu.show(style: style, from: self)
    }
    
    ///////// Check Functions
    func isBuy() -> Bool
    {
        if self.post_obj.post_type == "buy"
        {
            return true
        }
        return false
    }
    
    func isMotorBike() -> Bool
    {
        if self.post_obj.category == 2
        {
            return true
        }
        return false
    }
    
    //////// Table
    func getHeightbyIndexPath(indexpath: IndexPath) -> CGFloat
    {
        if indexpath.section == 0 && indexpath.row == 0
        {
            return 110
        }
        if indexpath.section == 1 && indexpath.row == 9
        {
            return 90
        }
        if indexpath.section == 1 && indexpath.row == 3 && isMotorBike()
        {
            return CGFloat.leastNonzeroMagnitude
        }
        return 50
    }
}

