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
    @IBOutlet weak var maxDur: UILabel!
    @IBOutlet weak var currDur: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var equipment: Equipment!
    
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
