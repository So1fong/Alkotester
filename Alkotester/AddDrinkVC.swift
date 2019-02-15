//
//  AddDrinkVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 11.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

var drinkNameArray: [String] = []
var drinkVolumeArray: [Double] = []
var drinkQuantityArray: [Int] = []

class AddDrinkVC: UIViewController
{
    @IBOutlet weak var hungerSlider: UISlider!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        quantityTextField.text = String(drinkList[myIndex].quantity)
        volumeTextField.text = String(drinkList[myIndex].volume)
    }
    
    // MARK: - Navigation
    @IBAction func cancelButtonTapped(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton)
    {
        var tempQuantity: Int
        var tempVolume: Double
        var tempDrink: Drink

        if let quantity = Int(quantityTextField.text!)
        {
            tempQuantity = quantity
            if let volume = Double(volumeTextField.text!)
            {
                // проверка введенного значения крепости напитка
                if (volume < 0 || volume > 100)
                {
                    volumeTextField.text = ""
                }
                else
                {
                    tempVolume = volume
                    tempDrink = Drink(name: drinkList[myIndex].name, volume: tempVolume, quantity: tempQuantity)
                    drinkNameArray.append(tempDrink.name)
                    drinkVolumeArray.append(tempDrink.volume)
                    drinkQuantityArray.append(tempDrink.quantity)
                    print(drinkNameArray, drinkNameArray.count)
                    print(drinkVolumeArray, drinkVolumeArray.count)
                    print(drinkQuantityArray, drinkQuantityArray.count)
                    UserDefaults.standard.set(drinkNameArray, forKey: "settingsDrinkNameArray")
                    UserDefaults.standard.set(drinkVolumeArray, forKey: "settingsDrinkVolumeArray")
                    UserDefaults.standard.set(drinkQuantityArray, forKey: "settingsDrinkQuantityArray")
                    navigationController?.popViewController(animated: true)

                }
            }
        }
    }
    
}
