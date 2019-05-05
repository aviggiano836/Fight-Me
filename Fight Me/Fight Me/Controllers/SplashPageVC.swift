//
//  SplashPageVC.swift
//  Fight Me
//
//  Created by Student on 5/2/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class SplashPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Check if a user currently exists
        DispatchQueue.main.async() {
            if ( UserDefaults.standard.string(forKey: "user") == nil ) { //If not, send user to create a fighter profile
                //create user
                self.performSegue(withIdentifier: "newFighter", sender: self)
                
            } else { // Else send user to the tab bar controller
                self.performSegue(withIdentifier: "returningFighter", sender: self)
            }

        }
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "returingFighter" {
            //TODO - load user info
            
            let vc = segue.destination as! TabBarController
            
            //pass in loaded user
        }
    }
    

}
