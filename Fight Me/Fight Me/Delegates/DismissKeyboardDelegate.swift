//
//  DismissKeyboardDelegate.swift
//  Fight Me
//
//  Created by Student on 5/5/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class DismissKeyboardDelegate: NSObject, UITextFieldDelegate {
    
    //Dismiss key board on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
