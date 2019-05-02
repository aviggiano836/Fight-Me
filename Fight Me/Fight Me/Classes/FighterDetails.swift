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
    var bmi: Double?
    let baseFitnessLevel: Int = 10
    
    init(username:String, height:Double, weight:Double, birthday:Date){
        self.username = username
        self.height = height
        self.weight = weight
        self.birthday = birthday
    }
    
    //updates fitness level
    func calculateBaseFitnessLevel() -> Int {
        let bmi = self.getBMI()
        if( 18 < bmi && bmi < 24.9 ){               //normal weight, no change
            return baseFitnessLevel
        } else if ( 25 < bmi && bmi < 29.9 ) {      //overweight
            return baseFitnessLevel - 4
            
        } else if ( 12 < bmi && bmi < 17.9) {      //underweight
            return baseFitnessLevel - 4
    
        } else if ( 30 < bmi && bmi < 39.9 ){       //obese
            return baseFitnessLevel - 6
            
        } else {                                    //extremely obese or underweight
            return baseFitnessLevel - 10
        }
        
    }
    
    func calculateBMI(){
        let temp = height * 12
        bmi = ((weight * 703) / (temp*temp))
    }
    
    func updateHeight(newHeight:Double){
        self.height = newHeight
        self.calculateBMI()
    }
    
    func updateWeight(newWeight:Double){
        self.weight = newWeight
        self.calculateBMI()
    }
    
    func getHeight() -> Double{
        return height
    }
    
    func getWeight() -> Double{
        return weight
    }
    
    func getBMI() -> Double {
        calculateBMI()
        return bmi!
    }

}
