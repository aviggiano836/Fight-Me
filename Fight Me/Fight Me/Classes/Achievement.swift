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
    var eAward: Equipment?
    var pAward: Int
    var imagePath: String
    
    //award is equipment
    init(name:String,desc:String,eAward:Equipment,imagePath:String){
        self.name = name
        self.desc = desc
        self.eAward = eAward
        self.pAward = 0
        self.imagePath = imagePath
    }
    
    //award is points
    init(name:String,desc:String,pAward:Int,imagePath:String){
        self.name = name
        self.desc = desc
        self.eAward = nil
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
            return (eAward?.getName())!
        }else{
            return String(pAward)
        }
    }
    

}
