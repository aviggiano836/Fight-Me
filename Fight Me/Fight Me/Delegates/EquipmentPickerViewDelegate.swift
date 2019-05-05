//
//  EquipmentPickerViewDelegate.swift
//  Fight Me
//
//  Created by Student on 5/5/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class EquipmentPickerViewDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerData: [String] = [String]()
    var selectedRow = 0 //Default selected row
    
    // Helper function for taking in an array of Equipment and parsing into an array
    //      of Strings for the picker to display
    func initPickerData(equipment:[Equipment]) {
        for item in equipment {
            pickerData.append(item.getName())
        }
    }
    
    //Return the pickerData currently selected
    func getSelectedRowAsString() -> String {
        return pickerData[selectedRow]
    }
    
    // Store the current selected row for later use
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    //Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
}
