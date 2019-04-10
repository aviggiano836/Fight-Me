//
//  FitnessHandler.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit
import CoreMotion

class FitnessHandler: NSObject {
    
    //app variables
    var dailyActivityLevels:[Date:(Bool,Int)] = [:]
    
    
    //pedometer variables
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    
    func updateStepsForToday(){
        
    }
    
    func updateStepsForDate(){
        
    }
    
    @IBAction func test(_ sender: Any) {
        getStepsFromPedometer()
    }
    func getStepsFromPedometer(){
        print("im in")
        if CMPedometer.isStepCountingAvailable() {
            let calendar = Calendar.current
            pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
                print(data)
            }
        }
    }
    
    
}
