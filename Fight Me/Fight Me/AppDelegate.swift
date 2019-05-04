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
    var inventory: [Equipment] = []
    var fighter: Fighter?
    var fighterEquipment: [Equipment] = []

    func loadEquipment(){
        do {
            let plistPath = Bundle.main.path(forResource: "shop", ofType: "plist")!
            let data = try Data(contentsOf: URL(fileURLWithPath: plistPath))
            let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
            let tempArray = tempDict["Equipment"]! as! Array<[String:Any]>
            for dict in tempArray {
                let type =  dict["type"]! as! String
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
    
    func loadUser(equipmentHandler: EquipmentHandler, fitnessHandler: FitnessHandler){
        do {
            let plistPath = Bundle.main.path(forResource: "userData", ofType: "plist")!
            let data = try Data(contentsOf: URL(fileURLWithPath: plistPath))
            let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
            print("\(tempDict)")
            let dict = tempDict["Fighter"]! as! [String:Any]
            let skillPoints = dict["skillPoints"]! as! Int
            let fitnessLevel = dict["fitnessLevel"]! as! Int
            let stamina = dict["stamina"]! as! Int
            
            //equipment stuff
            let equipmentArray = dict["equipment"] as! Array<Any>
            
            let myequipment = (equipmentArray[0], equipmentArray[1]) as! (String, String)
            
            let weight = dict["weight"]! as! Double
            let height = dict["height"]! as! Double
            let birthday = dict["birthday"]! as! Date
            let name = dict["name"]! as! String

                //TODO: get equipment
                //TODO: get achievements
            self.fighter = Fighter(fitnessHandler: fitnessHandler, equipmentHandler:equipmentHandler, username: name, height: height, weight: weight, birthday: birthday, skillPoint: skillPoints, stamina: stamina, fitnessLevel: fitnessLevel, equiped: myequipment)
            
        } catch {
            print(error)
        }
    }
    func loadInventory(){
        do {
            let plistPath = Bundle.main.path(forResource: "userData", ofType: "plist")!
            let data = try Data(contentsOf: URL(fileURLWithPath: plistPath))
            let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
            print("\(tempDict)")
            let dict = tempDict["Fighter"]! as! [String:Any]
            //equipment stuff
            let inventoryArray = dict["inventory"] as! Array<Any>
            let tempEH = EquipmentHandler(allEquipment: allEquipment)
            for item in inventoryArray{
                let invItem = tempEH.getEquipment(name: item as! String)
                inventory.append(invItem)
            }
    
        } catch {
            print(error)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //steps
        let fh = FitnessHandler()
        fh.askHealthPermission()
        fh.updateSteps()
        Thread.sleep(forTimeInterval: 3.0)
        
        
        loadEquipment()
        
        //load user
        if(UserDefaults.standard.string(forKey: "user") != nil){
            //create user
        }else{
            /*let username = UserDefaults.standard.string(forKey: "user")
            let height = UserDefaults.standard.double(forKey: "height")
            let weight = UserDefaults.standard.double(forKey: "weight")
            let birthday = UserDefaults.standard.string(forKey: "birthday")
            let skillPoint = UserDefaults.standard.integer(forKey: "skillPoint")
            let stamina = UserDefaults.standard.integer(forKey: "stamina")
            let fitnessLevel = UserDefaults.standard.integer(forKey: "fitnessLevel")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from: birthday!)
            let fighter = Fighter(username: username!, height: height, weight: weight, birthday: date!, skillPoint: skillPoint, stamina: stamina, fitnessLevel: fitnessLevel)
            */
            loadInventory()
            let equipmentH = EquipmentHandler(allEquipment: allEquipment, userEquipment:inventory)
            loadUser(equipmentHandler: equipmentH, fitnessHandler: fh)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "returningFighter")
            self.window?.rootViewController = initialViewController
            
            tabBarController = initialViewController as! TabBarController
            
            //set up fight page
            let FightVC = tabBarController!.viewControllers![0] as! FightController
            FightVC.fighter = fighter
            FightVC.equipment = equipmentH
            
            //set up shop
            let ShopNavVC = tabBarController!.viewControllers![2] as! UINavigationController
            let ShopTableVC = ShopNavVC.viewControllers[0] as! ShopController
            ShopTableVC.equipmentHandler = equipmentH
            ShopTableVC.fighter = fighter
            
            //set up inventory
            let InvNavVC = tabBarController!.viewControllers![1] as! UINavigationController
            let InvTableVC = InvNavVC.viewControllers[0] as! InventoryController
            InvTableVC.equipmentHandler = equipmentH
            InvTableVC.fighter = fighter
            
            //set up profile
            let ProfileVC = tabBarController!.viewControllers![3] as! ProfileController
            ProfileVC.fighter = fighter
            ProfileVC.fitnessHandler = fh
            ProfileVC.equipmentHandler = equipmentH
        }
        
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

