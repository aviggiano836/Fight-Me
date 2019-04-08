//
//  EquipmentHandler.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class EquipmentHandler: NSObject {
    var allEquipment: Dictionary<String, Equipment>
    var userEquipment: Dictionary<String, Equipment>
    
    init(allEquipment: Dictionary<String, Equipment>, userEquipment: Dictionary<String, Equipment>) {
        self.allEquipment = allEquipment
        self.userEquipment = userEquipment
    }
    
    init(allEquipment: Dictionary<String, Equipment>) {
        self.allEquipment = allEquipment
        self.userEquipment = Dictionary()
    }
    
    func getEquipment(name:String) -> Equipment {
        return self.allEquipment[name]!
    }
    
    func getAllEquipment() -> Dictionary<String, Equipment> {
        return self.allEquipment
    }
    
    func getEquipmentOfType(type:EquipmentType) -> [Equipment] {
        var temp: [Equipment] = []
        for name in self.allEquipment.keys {
            var e = self.allEquipment[name]!
            switch (e.getType()) {
            case type:
                temp.append(e)
            default:
                break
            }
        }
        
        return temp
    }
    
    func getUserEquipment() -> Dictionary<String, Equipment> {
        return self.userEquipment
    }
    
    func getUserEquipmentOfType(type:EquipmentType) -> [Equipment] {
        var temp: [Equipment] = []
        for name in self.userEquipment.keys {
            var e = self.userEquipment[name]!
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
