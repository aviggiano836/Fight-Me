//
//  NewUserController.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class NewUserController: UIViewController, UITextFieldDelegate {

    let maxIntChar = 2
    
    //Helper
    let validator = InputValidator()
    
    //Fields
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var height_ft: UITextField!
    @IBOutlet weak var height_in: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    @IBAction func createUser(_ sender: Any) {
        //create user and send to landing page
        let inputs = validInputs()
        if inputs.count == 5 {
            //create user
            UserDefaults.standard.set(inputs["username"], forKey: "user")
            UserDefaults.standard.set(calculateHeight(feet: inputs["height_ft"] as! String, inches: inputs["height_in"] as! String), forKey: "height")
            UserDefaults.standard.set(inputs["weight"], forKey: "weight")
            UserDefaults.standard.set(inputs["birthday"], forKey: "birthday")
            
            //send user to tab bar controller
            //todo
        }
    }
    
    /*
     * Validate all the inputs and return them as a dictionary
     */
    func validInputs() -> [String:Any] {
        var temp: [String:Any] = [:]
        temp = validator.validateAndAddToDict(field: username, key: "username", text: username.text!, dict: temp)
        temp["birthday"] = dateAsString(date: birthdate.date)//Date picker has default date
        temp = validator.validateAndAddToDict(field: height_ft, key: "height_ft", text: height_ft.text!, dict: temp)
        temp = validator.validateAndAddToDict(field: height_in, key: "height_in", text: height_in.text!, dict: temp)
        temp = validator.validateAndAddToDict(field: weight, key: "weight", text: weight.text!, dict: temp)
        
        return temp
    }
    
    /*
     * Return height in just feet
     */
    func calculateHeight(feet:String, inches:String) -> Double{
        return (Double(feet)!) + (Double(inches)! / 12)
    }
    
    /*
     * Format date into a String
     */
    func dateAsString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        return dateFormatter.string(from: date)//Date picker has default date
    }
    
    //MARK - UITextField Delegates
    // For height and weight textfields - must take in only numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Input must be numbers,
        let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")//Has to be a number
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) && string.count < maxIntChar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        height_ft.delegate = self
        height_in.delegate = self
        weight.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
