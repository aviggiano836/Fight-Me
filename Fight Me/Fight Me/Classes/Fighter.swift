//
//  Fighter.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class Fighter: FighterDetails {
    
    var fitnessLevel: Int?
    var stamina: Int?
    var equiped: (weapon:Equipment,armor:Equipment)?
    var skillPoint: Int?
    var fitnessHandler: FitnessHandler?
    var equipmentH: EquipmentHandler?
    var achievements: AchievementHandler?
    
    override init(username:String, height:Double, weight:Double, birthday:Date) {
        super.init(username:username,height:height,weight:weight,birthday:birthday)
        fitnessLevel = super.calculateBaseFitnessLevel()
    }
    
    init(equipmentHandler: EquipmentHandler, username:String, height:Double, weight:Double, birthday:Date, skillPoint: Int, stamina: Int, fitnessLevel: Int, equiped: (String,String)) {
        super.init(username:username,height:height,weight:weight,birthday:birthday)
        self.equipmentH = equipmentHandler
        self.fitnessLevel = fitnessLevel
        self.stamina = stamina
        self.skillPoint = skillPoint
        
        //do equipment
        self.equiped = (equipmentH?.getEquipment(name: equiped.0), equipmentH?.getEquipment(name: equiped.1)) as? (weapon: Equipment, armor: Equipment)
        
        
    }

    func calculateFitnessLevel(){
        //for now basefitness level = fitnesslevel
        fitnessLevel = calculateBaseFitnessLevel()
    }
    
    func getFitnessLevel() -> Int{
        return fitnessLevel!
    }
    
    //creates a bundle with basic info used for calulating a fight
    func bundleFighter(){
        //TODO
    }
    
    //Returns a touple of what equpiment the fighter has equpied
    func getEquiped() -> (Equipment,Equipment)?{
        return equiped
    }

}
