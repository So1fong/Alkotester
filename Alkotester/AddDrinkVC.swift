//
//  AddDrinkVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 11.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

var drinkNameArray: [String] = []
var drinkVolumeArray: [Int] = []
var drinkQuantityArray: [Int] = []

class AddDrinkVC: UIViewController
{
    @IBOutlet weak var hungerSlider: UISlider!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var quantitySlider: UISlider!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customizeSliders()
        quantityLabel.text = String(drinkList[myIndex].quantity) + " мл"
        volumeLabel.text = String(drinkList[myIndex].minVolume) + "°"
        quantityTextField.text = String(drinkList[myIndex].quantity)
        volumeTextField.text = String(drinkList[myIndex].minVolume)
    }
    
    @IBAction func volumeSliderValueChanged(_ sender: UISlider)
    {
        let volumeSliderStep: Float = 1
        let currentValue = round(sender.value / volumeSliderStep) * volumeSliderStep
        sender.value = round(currentValue)
        volumeLabel.text = String(Int(volumeSlider.value)) + "°"
    }
    
    @IBAction func quantitySliderValueChanged(_ sender: UISlider)
    {
        let quantitySliderStep: Float = 50
        let currentValue = round(sender.value / quantitySliderStep) * quantitySliderStep
        sender.value = round(currentValue)
        quantityLabel.text = String(Int(quantitySlider.value)) + " мл"
    }
    
    func customizeSliders()
    {
        if let maxVolume = drinkList[myIndex].maxVolume
        {
            volumeSlider.isEnabled = true
            quantitySlider.isEnabled = true
            volumeSlider.maximumValue = Float(maxVolume)
            volumeSlider.minimumValue = Float(drinkList[myIndex].minVolume)
            quantitySlider.maximumValue = 1000
            quantitySlider.minimumValue = 50
        }
        else
        {
            volumeSlider.isEnabled = false
        }

    }
    
    // MARK: - Navigation
    @IBAction func cancelButtonTapped(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton)
    {
        var tempQuantity: Int
        var tempVolume: Int
        var tempDrink: Drink

        if let quantity = Int(quantityTextField.text!)
        {
            tempQuantity = quantity
            if let volume = Int(volumeTextField.text!)
            {
                // проверка введенного значения крепости напитка
                if (volume < 0 || volume > 100)
                {
                    volumeTextField.text = ""
                }
                else
                {
                    tempVolume = volume
                    tempDrink = Drink(name: drinkList[myIndex].name, minVolume: tempVolume, quantity: tempQuantity, maxVolume: drinkList[myIndex].maxVolume)
                    drinkNameArray.append(tempDrink.name)
                    drinkVolumeArray.append(tempDrink.minVolume)
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
