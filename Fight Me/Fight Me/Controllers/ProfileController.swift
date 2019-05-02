//
//  ProfileController.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    var fighter: Fighter?
    
    @IBOutlet weak var steps: UILabel!
    var fitnessHandler = FitnessHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HERE: setting text \(fitnessHandler.getStepsForToday())")
        steps.text = String(fitnessHandler.getStepsForToday())

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
