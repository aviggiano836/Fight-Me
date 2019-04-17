//
//  ShopController.swift
//  Fight Me
//
//  Created by Student on 4/17/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class ShopController: UITableViewController {

    @IBOutlet weak var display: UISegmentedControl?
    
    var equipmentHandler: EquipmentHandler?
    var equipment: [Equipment] = []
    
    @IBAction func displayChanged(sender:UISegmentedControl){
        switch self.display?.selectedSegmentIndex {
        case 0:
            self.equipment = (equipmentHandler?.getAllEquipment())!
        case 1:
            self.equipment = (equipmentHandler?.getEquipmentOfType(type: EquipmentType.WEAPON))!
        case 2:
            self.equipment = (equipmentHandler?.getEquipmentOfType(type: EquipmentType.ARMOR))!
        default:
            break
        }
        
        //Reload view
        self.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.equipment = (equipmentHandler?.getAllEquipment())!
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //# of equipment being displayed
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.display?.selectedSegmentIndex {
            case 0:
                return (equipmentHandler?.allEquipment.count)!
            case 1:
                return (equipmentHandler?.getEquipmentOfType(type: EquipmentType.WEAPON).count)!
            case 2:
                return (equipmentHandler?.getEquipmentOfType(type: EquipmentType.ARMOR).count)!
            default:
                return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        
        let equipment = self.equipment[indexPath.row]
        cell.textLabel?.text = equipment.getName()
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        
        print("Equipment Selected as row: \(indexPath!.row)")
        let equipment = self.equipment[indexPath!.row]
        let equipmentDetail = segue.destination as! EquipmentDetailController
        equipmentDetail.equipment = equipment
        
        
        equipmentDetail.title = equipment.getName()
    }
    

}
