//
//  FightController.swift
//  Fight Me
//
//  Created by Student on 4/8/19.
//  Copyright © 2019 Lauren DiDonato. All rights reserved.
//

import UIKit
import CoreBluetooth

class FightController: UIViewController, UITextFieldDelegate {
    let BAD_INPUT = UIColor(cgColor: #colorLiteral(red: 1, green: 0.6700618703, blue: 0.7056196374, alpha: 1))
    let GOOD_INPUT = UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    //Helpers
    let alerts = AlertHelper()
    
    //Fighter Variables
    var fighter: Fighter?
    var equipment: EquipmentHandler?
    
    //Mock Fight Variables
    @IBOutlet weak var opponentLevel: UITextField!
    @IBOutlet weak var opponentSteps: UITextField!
    @IBOutlet weak var opponentWeapon: UIPickerView!
    @IBOutlet weak var opponentArmor: UIPickerView!
    
    //Picker view delegates
    var weaponPVD = EquipmentPickerViewDelegate()
    var armorPVD = EquipmentPickerViewDelegate()
    
    // Validate that the the inputs are completed and the fighter still has stamina left
    //      if yes, simulate fight and create alerts
    //      if not, alert user in some fashion
    @IBAction func validateAndFight(_ sender: UIButton) {
        if validInputs() {
            if ((fighter?.stamina)! > 0) {
                fight()
            } else {
                alerts.showAlert(view: self, title: "Oh No", message: "You're out of stamina, come back tomorrow", action: "Aww")
            }
        }
    }
    
    //Validate that all the text fields have been properly filled out
    func validInputs() -> Bool{
        let validLevel = validateTextField(field: opponentLevel)
        let validSteps = validateTextField(field: opponentSteps)
        return validLevel && validSteps
    }
    
    /*
     * Validate that a text field has valid input string
     *      if valid append the input to the given dictionary and return it
     *          and change the text fields background color to white in case changed previously
     *      if invalid change the background color or the given text field to BAD_INPUT, pink
     */
    func validateTextField(field: UITextField) -> Bool{
        if field.text == "" {
            field.backgroundColor = BAD_INPUT
            return false
        } else {
            field.backgroundColor = GOOD_INPUT
            return true
        }
    }
    
    // Determine who wins based on the existing fighter and the given opponent variables
    //      Fight Level is based on the fighter's current level, steps, and buff from their equipment
    //      Fighter with the highest level wins
    func fight(){
        //Get fighter's fight level
        let fighterLevel = calculateUserLevel(level: (fighter?.getFitnessLevel())!,
                                              steps: (fighter?.fitnessHandler?.getStepsForToday())!,
                                              weapon: (fighter?.getEquiped()?.0)!,
                                              armor: (fighter?.getEquiped()?.1)!)
        
        // Calculate Opponent's fight level
        // Kept getting weird error when trying to convert the string to a double inline:
        //      Expression type '@lvalue String?' is ambiguous without more context
        let steps = Int((self.opponentSteps?.text)!) //Double(self.opponentSteps.text)
        let level = Int((self.opponentLevel?.text)!)
        let equipmentLevel = Double((equipment?.getEquipment(name: weaponPVD.getSelectedRowAsString()).getBuff())!) + Double((equipment?.getEquipment(name: armorPVD.getSelectedRowAsString()).getBuff())!)
        let opponentFightLevel = Double(level!) + (Double(steps!)/1000) + equipmentLevel + Double.random(in: 0..<2) //Luck
        
        //Fighter with the highest level wins
        if fighterLevel > opponentFightLevel {
            alerts.showAlert(view: self, title: "Nice", message: "You won the fight by \(String(format:"%.2f", fighterLevel - opponentFightLevel)) points", action: "Coolio", subAlert: getFightAfterMathAlert(fighterWon: true))
            
        } else if opponentFightLevel > fighterLevel {
            alerts.showAlert(view: self, title: "Boooo!", message: "You lose", action: ":'(", subAlert: getFightAfterMathAlert(fighterWon: false))
            
        } else { //Fighters as even, Stabby the Crabby appears
            alerts.showAlert(view: self, title: "No winners here", message: "Stabby the Crabby got both of you", action: "Crabtastic", subAlert: getFightAfterMathAlert(fighterWon: false))
        }
    }
    
    func getFightAfterMathAlert(fighterWon:Bool) -> UIAlertController{
        // Aftermath: always lose 1 stamina and use equipment
        fighter?.stamina = (fighter?.stamina)! - 1
        fighter?.getEquiped()?.0.useEquipment()
        fighter?.getEquiped()?.1.useEquipment()
        var message = "You lost 1 stamina" //Starting message
        
        if fighterWon { //Get some skill points
            let spGain = Int.random(in: 1..<4) //Store spGain for alert message
            fighter?.skillPoint = (fighter?.skillPoint)! + spGain
            message = message + " and gained \(spGain) SP"
        }
        return alerts.createAlert(view: self, title: "Aftermath", message: message, action: "OK")
    }
    
    // Calculate User Level based on the Fighters level, # of steps, and used equipment
    //      Each 1000 steps counts as 1 level
    //      Each Equipment has a buff amount that counts toward the user's level
    func calculateUserLevel(level: Int, steps: Double, weapon:Equipment, armor: Equipment) -> Double{
        let stepLevel = steps / 1000 //Each 1000 steps counts as 1 point
        return stepLevel + Double(level + weapon.getBuff() + armor.getBuff()) + Double.random(in: 0..<2) //Luck
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opponentSteps.delegate = self
        opponentLevel.delegate = self
        
        //Populate the opponent weapon PickerView
        weaponPVD.initPickerData(equipment: (equipment?.getEquipmentOfType(type: EquipmentType.WEAPON))!)
        opponentWeapon.delegate = weaponPVD
        
        //Populate the opponent armor PickerView
        armorPVD.initPickerData(equipment: (equipment?.getEquipmentOfType(type: EquipmentType.ARMOR))!)
        opponentArmor.delegate = armorPVD
        
        //Bluetooth initializations
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        //Something after this is wrong and causes [CoreBluetooth] XPC connection invalid
        //
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)

    }
    
    //Dismiss key board on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // - Bluetooth Stuff
    
    //Bluetooth Variables
    let SERVICE_UUID = CBUUID.init()
    let WR_UUID = CBUUID.init()
    let WR_PROPERTIES: CBCharacteristicProperties = .write
    let WR_PERMISSIONS: CBAttributePermissions = .writeable
    var deviceUUID : UUID?
    var deviceAttributes : String = ""
    var selectedPeripheral : CBPeripheral?
    var centralManager: CBCentralManager?
    var peripheralManager = CBPeripheralManager()
    
    //Outlet and actions for attempting a bluetooth connection
    @IBOutlet weak var connectionLabel: UILabel!
    @IBAction func tryConnecting(_ sender: UIButton) {
        if (selectedPeripheral != nil){
            centralManager?.connect(selectedPeripheral!, options: nil)
            connectionLabel?.text = "Starting"
        } else {
            connectionLabel?.text = "Not connected"
        }
    }

    //Data is used by bluetooth to tell other bluetooth devices what it is
    func updateAdvertisingData() {
        if (peripheralManager.isAdvertising) {
            peripheralManager.stopAdvertising()
        }
        
        //Should be updated to Fighter name and details
        let advertisementData = String(format: "Ready to Fight")
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[SERVICE_UUID], CBAdvertisementDataLocalNameKey: advertisementData])
    }
    
    //Initialize bluetooth services
    func initService() {
        let serialService = CBMutableService(type: SERVICE_UUID, primary: true)
        let writeCharacteristics = CBMutableCharacteristic(type: WR_UUID,
                                                           properties: WR_PROPERTIES, value: nil,
                                                           permissions: WR_PERMISSIONS)
        serialService.characteristics = [writeCharacteristics]
        peripheralManager.add(serialService)
    }

}

//Extension for implementing the CBCetnralManagerDelegate for the device to begin receiving bluetooth signals
extension FightController : CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state { //Check the current state
        case .unknown:
            print("unknown")
        case .resetting:
            print("resetting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
            print("unauthorized")
        case .poweredOff:
            print("powered off")
        case .poweredOn:
            print("powered on")
        }
        
        if (central.state == .poweredOn){
            self.centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    //Handle discovering of a peripheral
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if (peripheral.identifier == deviceUUID) {
            
            selectedPeripheral = peripheral
        }
    }
    
    //Handle successful connection to a peripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("central did connect")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
    }
}

//Fighter is also a peripheral, send data over bluetooth to other fighters
extension FightController : CBPeripheralDelegate {
    
    func peripheral( _ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverCharacteristicsFor service: CBService,
        error: Error?) {

    }
}

//Manager for Fighter to act as a PeripheralManagerDelegate
extension FightController : CBPeripheralManagerDelegate {
    // Initialize stuff for acting as a peripheral once powered on
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if (peripheral.state == .poweredOn){
            initService()
            updateAdvertisingData()
        }
    }
    
    //Handle responses for another fighter
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        for request in requests {
            if let value = request.value {
                
                let messageText = String(data: value, encoding: String.Encoding.utf8) as String!
                //appendMessageToChat(message: Message(text: messageText!, isSent: false))
            }
            self.peripheralManager.respond(to: request, withResult: .success)
        }
    }
}

