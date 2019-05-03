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
    let BAD_INPUT = UIColor(cgColor: #colorLiteral(red: 1, green: 0.6700618703, blue: 0.7056196374, alpha: 1))
    let GOOD_INPUT = UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var height_ft: UITextField!
    @IBOutlet weak var height_in: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    /*let username = UserDefaults.standard.string(forKey: "user")
     let height = UserDefaults.standard.double(forKey: "height")
     let weight = UserDefaults.standard.double(forKey: "weight")
     let birthday = UserDefaults.standard.string(forKey: "birthday")
     let skillPoint = UserDefaults.standard.integer(forKey: "skillPoint")
     let stamina = UserDefaults.standard.integer(forKey: "stamina")
     let fitnessLevel = UserDefaults.standard.integer(forKey: "fitnessLevel")*/
    
    @IBAction func createUser(_ sender: Any) {
        //create user and send to landing page
        let inputs = validInputs()
        if inputs.count == 5 {
            //create user
            print("creating user")
            
            UserDefaults.standard.set(inputs["username"], forKey: "user")
            UserDefaults.standard.set(calculateHeight(feet: inputs["height_ft"] as! String, inches: inputs["height_in"] as! String), forKey: "height")
            UserDefaults.standard.set(inputs["weight"], forKey: "weight")
            UserDefaults.standard.set(inputs["birthday"], forKey: "birthday")
            
            //send user to tab bar controller
            
        }
    }
    
    /*
     * Validate all the inputs and return them as a dictionary
     */
    func validInputs() -> [String:Any] {
        var temp: [String:Any] = [:]
        
        temp = validateTextField(field: username, key: "username", text: username.text!, dict: temp)
        temp["birthday"] = dateAsString(date: birthdate.date)//Date picker has default date
        temp = validateTextField(field: height_ft, key: "height_ft", text: height_ft.text!, dict: temp)
        temp = validateTextField(field: height_in, key: "height_in", text: height_in.text!, dict: temp)
        temp = validateTextField(field: weight, key: "weight", text: weight.text!, dict: temp)
        
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
    
    /*
     * Validate that a text field has valid input string
     *      if valid append the input to the given dictionary and return it
     *          and change the text fields background color to white in case changed previously
     *      if invalid change the background color or the given text field to BAD_INPUT, pink
     */
    func validateTextField(field: UITextField, key:String, text:String, dict: [String:Any]) -> [String:Any]{
        var temp = dict
        if text == "" {
            field.backgroundColor = BAD_INPUT
        } else {
            temp[key] = text
            field.backgroundColor = GOOD_INPUT
        }
        return temp
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
