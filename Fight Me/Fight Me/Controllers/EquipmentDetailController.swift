//
//  EquipmentDetailController.swift
//  Fight Me
//
//  Created by Student on 4/17/19.
//  Copyright © 2019 Ariel Viggiano. All rights reserved.
//

import UIKit

class EquipmentDetailController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Durr: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var equipBtn: UIButton!
    
    var buyBool: Bool!
    var equipment: Equipment!
    var fighter: Fighter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = equipment.getName()
        desc.text = equipment.getDesc()
        type.text = equipment.getTypeAsString()
        Durr.text = "\(equipment.getMaxDurability()) \\ \(equipment.getCurrentDurability())"
        
        cost.text = "\(equipment.getCost()) SP"
        let eimage: UIImage = UIImage(named: equipment.getImagePath())!
        image.image = eimage
        
        if(!buyBool){
            buyBtn.isHidden = true
            buyBtn.isEnabled = false
        }else{
            equipBtn.isHidden = true
            equipBtn.isEnabled = false
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func purchaseItem(_ sender: Any) {
        let alert = UIAlertController(title: "Purchase \(equipment.getName())", message: "Buy \(equipment.getName()) for \(equipment.getCost()) SP?", preferredStyle: .alert)
        
        // Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (action) -> Void in
            let check = self.fighter.buyItem(item: self.equipment)
            if(check){
                let alert = UIAlertController(title: "Success!", message: "You bought a \(self.equipment.getName())!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //do nothing
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Opps", message: "You are unable to buy a \(self.equipment.getName()). You either already own one, or don't have enough SP!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //do nothing
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            //do nothing
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func equipItem(_ sender: Any) {
        let alert = UIAlertController(title: "Equip \(equipment.getName())", message: "This item will be equiped in your \(equipment.getType()) slot", preferredStyle: .alert)
        
        // Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (action) -> Void in
            /*
            let check = self.fighter.eq(item: self.equipment)
            if(check){
                let alert = UIAlertController(title: "Success!", message: "You bought a \(self.equipment.getName())!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //do nothing
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Opps", message: "You are unable to buy a \(self.equipment.getName()). You either already own one, or don't have enough SP!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //do nothing
                }))
                self.present(alert, animated: true, completion: nil)
            }
 */
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            //do nothing
        }))
        self.present(alert, animated: true, completion: nil)
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
