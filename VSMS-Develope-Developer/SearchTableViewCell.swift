//
//  SearchTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/24/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var Search: UISearchBar!
    
    @IBOutlet weak var btnsell: UIButton!
    @IBOutlet weak var btnrent: UIButton!
    @IBOutlet weak var btnbuy: UIButton!
    
    //Filter Properties
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtBrand: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    let Filter_Picker = UIPickerView()
    var active_arr : [String] = []
    var active_txt : UITextField!
    
    //Array list for Filter
    var Category_Arr = ["Motor", "Phone", "Car", "Other"]
    var Brand_Arr = ["Honda", "Yamaha", "Suzuki"]
    var Year_Arr = ["2015", "2016", "2017", "2018", "2019"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let textFieldInsideUISearchBar = Search.value(forKey: "searchField") as? UITextField
        let italicfont = UIFont.italicSystemFont(ofSize: 20)
        textFieldInsideUISearchBar?.backgroundColor = UIColor.white
        // UIFont.init(name: "AmericanTypewrite-italic", size: 20)
        //  textFieldInsideUISearchBar?.textColor = UIColor.red
        // textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(20)
        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.textColor = UIColor.lightGray
        textFieldInsideUISearchBarLabel?.font = italicfont
        // textFieldInsideUISearchBarLabel?.font = UIFont(name: "AmericanTypewrite-italic", size: 20)
        
        FilterPickerConfig()
        CreateToolbarForPicker()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Filter Handler //////////
    
    func FilterPickerConfig(){
        txtCategory.delegate = self
        txtBrand.delegate = self
        txtYear.delegate = self
        
        Filter_Picker.delegate = self
        Filter_Picker.dataSource = self
        
        txtCategory.inputView = Filter_Picker
        txtBrand.inputView = Filter_Picker
        txtYear.inputView = Filter_Picker
    }
    
    func CreateToolbarForPicker(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        txtCategory.inputAccessoryView = toolBar
        txtBrand.inputAccessoryView = toolBar
        txtYear.inputAccessoryView = toolBar
    }
    
    @objc func doneClick(){
        active_txt.resignFirstResponder()
    }
    
    @objc func cancelClick(){
        active_txt.text = ""
        active_txt.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        active_txt = textField
        switch textField{
        case txtCategory: active_arr = Category_Arr
        case txtBrand: active_arr = Brand_Arr
        case txtYear: active_arr = Year_Arr
        default: active_arr = []
        }
        
        Filter_Picker.reloadAllComponents()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return active_arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return active_arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        active_txt.text = active_arr[row]
    }
    
    //End Filter Handler //////////////////
}
