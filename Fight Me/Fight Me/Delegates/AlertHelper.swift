//
//  AlertHelper.swift
//  Fight Me
//
//  Created by Student on 5/5/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class AlertHelper {
    
    // Create an alert with the given title, message, and single action
    //      Optional subAlert is an optional UIAlertController that will be shown after the user clicks the action
    func showAlert(view: UIViewController, title:String, message:String, action:String, subAlert: UIAlertController? = nil){
        let alert = createAlert(view: view, title: title, message: message, action: action, subAlert: subAlert)
        view.present(alert, animated: true)
    }
    
    // Create an alert with the given title, message,
    //      Add action with the given action title, and show subAlert if one is given
    func createAlert(view: UIViewController, title:String, message:String, action:String, subAlert: UIAlertController? = nil) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { [weak alert] (action) -> Void in
            if subAlert != nil {
                view.present(subAlert!, animated: true, completion: nil)
            }
        }))
        return alert
    }
}
