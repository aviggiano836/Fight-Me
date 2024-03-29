//
//  Equipment.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit


enum EquipmentType{
    case WEAPON
    case ARMOR
}

class Equipment: NSObject {

    var maxDurability: Int?
    var currentDurability: Int?
    var name: String?
    var desc: String?
    var type: EquipmentType?
    var buff: Int
    var cost: Int?
    var imagePath: String?
    var isAward: Bool
    
    init(maxDurability:Int, currentDurability:Int, name:String, desc:String, type:String, buff:Int, cost:Int, imagePath:String, isAward:Bool){
        self.maxDurability = maxDurability
        self.currentDurability = currentDurability
        self.name = name
        self.desc = desc
        switch type {
            case "weapon":
                self.type = EquipmentType.WEAPON
            case "armor":
                self.type = EquipmentType.ARMOR
            default:
                break
        }
        self.buff = buff
        self.cost = cost
        self.imagePath = imagePath
        self.isAward = isAward
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
    
    func getType() -> EquipmentType {
        return self.type!
    }
    
    func getTypeAsString() -> String{
        switch self.type! {
            case EquipmentType.ARMOR:
                return "ARMOR"
            case EquipmentType.WEAPON:
                return "WEAPON"
        }
    }
    
    func useEquipment() -> Int{
        self.currentDurability = self.currentDurability! - 1
        return self.currentDurability!
    }
    
    func getBuff() -> Int {
        return self.buff
    }
    
    func getIsAward() -> Bool {
        return self.isAward
    }
    
    func getImagePath() -> String {
        return self.imagePath!
    }
    
    func getCost() -> Int {
        return self.cost!
    }
    
    
}
