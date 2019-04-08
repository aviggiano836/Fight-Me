//
//  FighterDetails.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

class FighterDetails: NSObject {
    let username: String
    var height: Double
    var weight: Double
    var birthday: Date
    
    init(username:String, height:Double, weight:Double, birthday:Date){
        self.username = name
        self.height = height
        self.weight = weight
        self.birthday = birthday
    }
    
    func updateHeight(newHeight:Double){
        self.height = newHeight
    }
    
    func updateWeight(newWeight:Double){
        self.height = newHeight
    }

}
