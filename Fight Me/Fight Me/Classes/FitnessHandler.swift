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
    private var currSteps: Double = 0.0
    
    
    //pedometer variables
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private let healthStore = HKHealthStore()
    

    func getStepsForToday() -> Double{
        updateSteps()   //will not finish for a while
        return self.currSteps
    }
    
    private func setCurrSteps(steps:Double){
        print("HERE: setting steps \(steps)")
        self.currSteps = steps
    }
    
    func askHealthPermission(){
        let healthKitTypes: Set = [
            // access step count
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        ]
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (_, _) in
            print("authorised???")
        }
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (bool, error) in
            if let e = error {
                print("oops something went wrong during authorisation \(e.localizedDescription)")
            } else {
                print("User has completed the authorization flow")
            }
        }
    }
    private func getTodaysSteps(completion: @escaping (Double) -> Void) {
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                completion(resultCount)
                return
            }
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }
            
            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        healthStore.execute(query)
    }
    func updateSteps(){
        getTodaysSteps { (result) in
            self.setCurrSteps(steps:result)
            DispatchQueue.main.async {
                print("Total Steps: \(result)")
                self.setCurrSteps(steps: result)
            }
        }
    }
    
    
    
}
