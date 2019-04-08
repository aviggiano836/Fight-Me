//
//  Achievement.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class Achievement: NSObject {
    
    var name: String
    var desc: String
    //var requirement:
    var eAward: Equipment
    var pAward: Int
    var imagePath: String
    
    //if not pAward then set to 0, if not equipment IDK
    init(name:String,desc:String,eAward:Equipment,pAward:Int,imagePath:String){
        self.name = name
        self.desc = desc
        self.eAward = eAward
        self.pAward = pAward
        self.imagePath = imagePath
    }
    
    func getName()->String{
        return name
    }
    
    func getDesc()->String{
        return desc
    }
    
    //returns the award for the achievement either skill points OR an equipment
    func getAward()->String{
        if(pAward == 0){
            return eAward.getName()
        }else{
            return String(pAward)
        }
    }
    

}
