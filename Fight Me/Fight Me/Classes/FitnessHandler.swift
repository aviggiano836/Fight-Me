//
//  FitnessHandler.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit
import CoreMotion
import HealthKit

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
        pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
            if let pedData = pedometerData{
                print("Steps:\(pedData.numberOfSteps)")
            } else {
                print("Steps: Not Available")
            }
        })
    }
    let healthStore = HKHealthStore()
    
    func getTodaysSteps() {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                return
            }
            print(sum.doubleValue(for: HKUnit.count()))
        }
        healthStore.execute(query)
    }
    
    
    
}
