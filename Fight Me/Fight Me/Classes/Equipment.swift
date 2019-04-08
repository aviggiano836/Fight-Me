//
//  Equipment.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class Equipment: NSObject {
    enum EquipmentType{
        case WEAPON
        case ARMOR
    }
    
    var maxDurability: Int?
    var currentDurability: Int?
    var name: String?
    var desc: String?
    var buff: (EquipmentType, Int)?
    var cost: Int?
    var imagePath: String?
    
    init(maxDurability:Int, currentDurability:Int, name:String, desc:String, buff:(EquipmentType, Int), cost:Int, imagePath:String){
        self.maxDurability = maxDurability
        self.currentDurability = currentDurability
        self.name = name
        self.desc = desc
        self.buff = buff
        self.cost = cost
        self.imagePath = imagePath
    }
    
    func getName() -> String{
        return self.name!
    }
    
    func getDesc() -> String{
        return self.desc!
    }
    
    func getMaxDurability() -> Int{
        return self.maxDurability!
    }
    
    func getCurrentDurability() -> Int{
        return self.currentDurability!
    }
    
    func useEquipment() -> Int{
        self.currentDurability = self.currentDurability! - 1
        return self.currentDurability!  
    }
    
    func getBuff() -> (EquipmentType, Int) {
        return self.buff!
    }
    
    
}
