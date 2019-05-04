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
    var equipmentHandler: EquipmentHandler?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fitnessLevelLabel: UILabel!
    @IBOutlet weak var skillPointsLabel: UILabel!
    @IBOutlet weak var steps: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var armorImage: UIImageView!
    
    @IBOutlet weak var fitnessLevelBar: UIProgressView!
    @IBOutlet weak var staminaBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        fighter?.calculateFitnessLevel()
        steps.text = String(Int((fighter?.fitnessHandler!.getStepsForToday())!))
        nameLabel.text = fighter?.username
        fitnessLevelLabel.text = String(format:"%d", (fighter?.fitnessLevel)!)
        skillPointsLabel.text = String(format:"%d", (fighter?.skillPoint)!)
        
        //height
        heightLabel.text = "\(String((fighter?.height)!)) '"
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileController.tapHeight))
        heightLabel.isUserInteractionEnabled = true
        heightLabel.addGestureRecognizer(tap)
        
        //weight
        weightLabel.text = "\(String((fighter?.weight)!)) lbs"
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ProfileController.tapWeight))
        weightLabel.isUserInteractionEnabled = true
        weightLabel.addGestureRecognizer(tap2)
        
        fitnessLevelBar.setProgress((Float(Double((fighter?.fitnessLevel)!) / 10)), animated: true)
        staminaBar.setProgress((Float(Double((fighter?.stamina)!) / 10)), animated: true)
        
        //equipment
        let armorName = fighter?.equiped?.armor
        let weaponName = fighter?.equiped?.weapon
        
        let wimage: UIImage = UIImage(named: (weaponName?.imagePath)!)!
        weaponImage.image = wimage
        let aimage: UIImage = UIImage(named: (armorName?.imagePath)!)!
        armorImage.image = aimage
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapHeight(sender:UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Edit Height", message: "Enter your height:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
            textField.text = "\(String(format:"%.1f",(self.fighter?.height)!))"
        }
        
        // Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0]
             if(textField.text != ""){
                self.fighter?.updateHeight(newHeight: Double(textField.text!)!)
                self.updateUI()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            //do nothing
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func tapWeight(sender:UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Edit Weight", message: "Enter your weight:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
            textField.text = "\(String(format:"%.1f",(self.fighter?.weight)!))"
        }
        
        // Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0]
            if(textField.text != ""){
                self.fighter?.updateWeight(newWeight: Double(textField.text!)!)
                self.updateUI()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            //do nothing
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
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
