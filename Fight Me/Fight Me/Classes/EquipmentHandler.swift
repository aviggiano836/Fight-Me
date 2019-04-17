//
//  EquipmentHandler.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class EquipmentHandler: NSObject {
    var allEquipment: [String:Equipment]
    var userEquipment: [String:Equipment]
    
    // Init EquipmentHandler with dictionary of available Equipment and user's current equipment
    init(allEquipment: [String:Equipment], userEquipment: [String:Equipment]) {
        self.allEquipment = allEquipment
        self.userEquipment = userEquipment
    }
    
    // Init EquipmentHandler with dictionary of available Equipment
    init(allEquipment: [String:Equipment]) {
        self.allEquipment = allEquipment
        self.userEquipment = [:]
    }
    
    // Get an equipment base on it's name
    func getEquipment(name:String) -> Equipment {
        return self.allEquipment[name]!
    }
    
    // Get all the equipment available
    func getAllEquipment() -> [Equipment] {
        var temp: [Equipment] = []
        for name in self.allEquipment.keys {
            temp.append(self.allEquipment[name]!)
        }
        
        return temp
    }
    
    // Get all the equipment with the matching type
    func getEquipmentOfType(type:EquipmentType) -> [Equipment] {
        var temp: [Equipment] = []
        for name in self.allEquipment.keys {
            let e = self.allEquipment[name]!
            switch (e.getType()) {
            case type:
                temp.append(e)
            default:
                break
            }
        }
        
        return temp
    }
    
    // Item has been bought or stolen from opponent. As to user's list
    func addEquipment(equipment:Equipment){
        self.userEquipment[equipment.getName()] = equipment
    }
    
    // Item has been stolen from user. Remove equipment from user's list
    func removeEquipment(equipName:String){
        self.userEquipment.removeValue(forKey: equipName)
    }
    
    // Validate that all the user's equipment has a durability above 0
    //      must be above 0 durability for the user to use
    func validateUserEquipment(){
        for e in userEquipment.keys {
            if userEquipment[e]!.getCurrentDurability() <= 0{
                userEquipment.removeValue(forKey: e)
            }
        }
    }
    
    // Return all the user's equipment
    func getUserEquipment() -> [String:Equipment] {
        return self.userEquipment
    }
    
    // Return all the user's equipment with the matching type
    func getUserEquipmentOfType(type:EquipmentType) -> [Equipment] {
        var temp: [Equipment] = []
        for name in self.userEquipment.keys {
            let e = self.userEquipment[name]!
            switch (e.getType()) {
            case type:
                temp.append(e)
            default:
                break
            }
        }
        
        return temp
    }
    
}
