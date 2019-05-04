//
//  InventoryController.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Ariel Viggiano. All rights reserved.
//

import UIKit

class InventoryController: UITableViewController {
    @IBOutlet weak var display: UISegmentedControl?
    
    var equipmentHandler: EquipmentHandler?
    var equipment: [Equipment] = []
    var fighter: Fighter?
    
    @IBAction func displayChanged(sender:UISegmentedControl){
        switch self.display?.selectedSegmentIndex {
        case 0:
            self.equipment = (equipmentHandler?.getUserEquipment())!
        case 1:
            self.equipment = (equipmentHandler?.getUserEquipmentOfType(type: EquipmentType.WEAPON))!
        case 2:
            self.equipment = (equipmentHandler?.getUserEquipmentOfType(type: EquipmentType.ARMOR))!
        default:
            break
        }
        
        //Reload view
        self.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.equipment = equipmentHandler?.getUserEquipment() ?? []
        
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
            return (equipmentHandler?.getUserEquipment().count)!
        case 1:
            return (equipmentHandler?.getUserEquipmentOfType(type: EquipmentType.WEAPON).count)!
        case 2:
            return (equipmentHandler?.getUserEquipmentOfType(type: EquipmentType.ARMOR).count)!
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        let equipment = self.equipment[indexPath.row]
        cell.textLabel?.text = equipment.getName()
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let equip = equipment[indexPath.row]
        let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EquipmentDC") as? EquipmentDetailController
        detailVC!.title = equip.getName()
        detailVC!.equipment = equip
        navigationController?.pushViewController(detailVC!, animated: true)
        
    }
}
