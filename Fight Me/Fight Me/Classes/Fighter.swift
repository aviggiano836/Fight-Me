//
//  Fighter.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class Fighter: FighterDetails {
    
    var fitnessLevel: Double?
    var stamina: Int?
    var equiped: (weapon:Equipment,armor:Equipment)
    var skillPoint: Int?
    var fitnessHandler: FitnessHandler?
    var equipment: EquipmentHandler?
    var achievements: AchievementHandler
    
    
    init(username:String, height:Double, weight:Double, birthday:Date) {
        super.init(username:username,height:height,weight:weight,birthday:birthday)
    }

    //updates fitness level
    func calculateFitnessLevel(){
        //TODO
    }
    
    //creates a bundle with basic info used for calulating a fight
    func bundleFighter(){
        //TODO
    }
    
    //Returns a touple of what equpiment the fighter has equpied
    func getEquiped() -> (Equipment,Equipment){
        return equiped
    }
    
    

}
