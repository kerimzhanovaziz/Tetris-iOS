//
//  OptionsViewController.swift
//  TetrisReturns
//
//  Created by ITLabAdmin on 5/3/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

//    func setupPickerView() {
//        let pv = UIPickerView()
//        pv.delegate = self
//        view.inputView = pv
//        //textField.inputView = pv
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.de
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            setupPickerView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /*
     UIPickerViewDelegate, UIPickerViewDataSource {
     
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     if pickerView == regionPickerView {
     return regions.count
     }
     return categories.count
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     if pickerView == regionPickerView {
     return regions[row].city_name
     } else {
     return categories[row].category_name
     }
     }
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     if pickerView == regionPickerView {
     productRegionTextField.text = regions[row].city_name
     } else {
     selectedCategory = categories[row].id
     productCategoryTextField.text = categories[row].category_name
     }
     }
     }
     */
}
