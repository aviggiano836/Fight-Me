//
//  AppDelegate.swift
//  Fight Me
//
//  Created by Lauren DiDonato on 4/3/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController?
    var allEquipment: [Equipment] = []

    func loadEquipment(){
        do {
            let plistPath = Bundle.main.path(forResource: "shop", ofType: "plist")!
            let data = try Data(contentsOf: URL(fileURLWithPath: plistPath))
            let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
            print("\(tempDict)")
            let tempArray = tempDict["Equipment"]! as! Array<[String:Any]>
            for dict in tempArray {
                let type = dict["type"]! as! EquipmentType
                let icon = dict["icon"]! as! String
                let isAward = dict["isAward"]! as! Bool
                let spCost = dict["spCost"]! as! Int
                let maxDurability = dict["maxDurability"]! as! Int
                let buff = dict["buff"]! as! Int
                let desc = dict["description"]! as! String
                let name = dict["name"]! as! String
                
                //you need to provide all of the values from the plist and possibly modify the initializer with any new values...
                let e = Equipment(maxDurability:maxDurability, currentDurability:maxDurability, name:name, desc:desc, type:type, buff:buff, cost:spCost, imagePath:icon, isAward:isAward)
                
                allEquipment.append(e)
            }
            
            
        } catch {
            print(error)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadEquipment()
        tabBarController = window?.rootViewController as? UITabBarController
        let ShopNavVC = tabBarController!.viewControllers![2] as! UINavigationController
        //let equipmentH = EquipmentHandler(allEquipment: allEquipment)
        
        let ShopTableVC = ShopNavVC.viewControllers[0] as! ShopController
        //ShopVC.
        
        
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

