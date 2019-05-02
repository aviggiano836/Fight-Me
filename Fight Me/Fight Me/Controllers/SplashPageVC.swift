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
        
        DispatchQueue.main.async() {
            if(UserDefaults.standard.string(forKey: "user") == nil){
                //create user
                self.performSegue(withIdentifier: "newFighter", sender: self)
            }else{
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
            //load user info
            let username = UserDefaults.standard.string(forKey: "user")
            let height = UserDefaults.standard.double(forKey: "height")
            let weight = UserDefaults.standard.double(forKey: "weight")
            let birthday = UserDefaults.standard.string(forKey: "birthday")
            let skillPoint = UserDefaults.standard.integer(forKey: "skillPoint")
            let stamina = UserDefaults.standard.integer(forKey: "stamina")
            let fitnessLevel = UserDefaults.standard.integer(forKey: "fitnessLevel")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from: birthday!)
            let fighter = Fighter(username: username!, height: height, weight: weight, birthday: date!, skillPoint: skillPoint, stamina: stamina, fitnessLevel: fitnessLevel)
            
            
            let vc = segue.destination as! TabBarController
            
            //pass in loaded user
        }
    }
    

}
