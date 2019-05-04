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
    
    //Fighter Variables
    var fighter: Fighter?
    var equipment: EquipmentHandler?
    
    //Mock Fight Variables
    @IBOutlet weak var opponentLevel: UITextField!
    @IBOutlet weak var opponentSteps: UITextField!
    @IBOutlet weak var opponentWeapon: UIPickerView!
    @IBOutlet weak var opponentArmor: UIPickerView!
    
    
    @IBAction func validateAndFight(_ sender: UIButton) {
        if validInputs() {
            fight()
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
    
    //Determine who wins based on the existing fighter and the given opponent variables
    func fight(){
        //Get levels
        let fighterLevel = calculateUserLevel(level: (fighter?.getFitnessLevel())!,
                                              steps: (fighter?.fitnessHandler?.getStepsForToday())!,
                                              weapon: (fighter?.getEquiped()?.0)!,
                                              armor: (fighter?.getEquiped()?.1)!)
        let opponentLevel = 9.0
        
        //Fight
        fighterLevel + opponentLevel
    }
    
    //Calculate User Level based on the Fighters level, # of steps, and used equipment
    //      Each 1000 steps counts as 1 level
    //      Each Equipment has a buff amount that counts toward the user's level
    func calculateUserLevel(level: Int, steps: Double, weapon:Equipment, armor: Equipment) -> Double{
        let stepLevel = steps / 1000 //Each 1000 steps counts as 1 point
        return stepLevel + Double(level + weapon.getBuff() + armor.getBuff())
    }
    
    //Populate the weapon picker with the available weapons for the opponent
    func populateWeapons(){
        //TODO
    }
    
    //Populate the weapon picker with the available weapons for the opponent
    func populateArmor(){
        //TODO
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opponentSteps.delegate = self
        opponentLevel.delegate = self
        
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

extension FightController : CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
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
            //self.centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
        
        if (central.state == .poweredOn){
            self.centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if (peripheral.identifier == deviceUUID) {
            
            selectedPeripheral = peripheral
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("central did connect")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
    }
}

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

extension FightController : CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if (peripheral.state == .poweredOn){
            initService()
            updateAdvertisingData()
        }
    }
    
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

