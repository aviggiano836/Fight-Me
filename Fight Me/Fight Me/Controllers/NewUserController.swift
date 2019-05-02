//
//  NewUserController.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class NewUserController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var height_ft: UITextField!
    @IBOutlet weak var height_in: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    
    @IBAction func createUser(_ sender: Any) {
        //create user and send to landing page
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
