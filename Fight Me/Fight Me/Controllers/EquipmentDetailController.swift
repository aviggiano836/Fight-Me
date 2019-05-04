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
    
    var equipment: Equipment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = equipment.getName()
        desc.text = equipment.getDesc()
        type.text = equipment.getTypeAsString()
        Durr.text = "\(equipment.getMaxDurability()) \\ \(equipment.getCurrentDurability())"
        
        cost.text = "\(equipment.getCost()) SP"
        let eimage: UIImage = UIImage(named: equipment.getImagePath())!
        image.image = eimage
        
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
