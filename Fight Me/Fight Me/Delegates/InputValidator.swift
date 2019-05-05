//
//  InputValidator.swift
//  Fight Me
//
//  Created by Student on 5/5/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class InputValidator: NSObject {
    let _BAD_INPUT = UIColor(cgColor: #colorLiteral(red: 1, green: 0.6700618703, blue: 0.7056196374, alpha: 1))
    let _GOOD_INPUT = UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    /*
     * Validate that a text field has valid input string
     *      if valid append the input to the given dictionary and return it
     *          and change the text fields background color to white in case changed previously
     *      if invalid change the background color or the given text field to BAD_INPUT, pink
     */
    func validateTextField(field: UITextField) -> Bool{
        if field.text == "" {
            field.backgroundColor = _BAD_INPUT
            return false
        } else {
            field.backgroundColor = _GOOD_INPUT
            return true
        }
    }
    
    /*
     * Validate that a text field has valid input string
     *      if valid append the input to the given dictionary and return it
     *          and change the text fields background color to white in case changed previously
     *      if invalid change the background color or the given text field to BAD_INPUT, pink
     */
    func validateAndAddToDict(field: UITextField, key:String, text:String, dict: [String:Any]) -> [String:Any]{
        var temp = dict
        if text == "" {
            field.backgroundColor = _BAD_INPUT
        } else {
            temp[key] = text
            field.backgroundColor = _GOOD_INPUT
        }
        return temp
    }
}
