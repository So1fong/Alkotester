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
var drinkDateArray: [Date] = []
var drinkHungerArray: [Int] = []

class AddDrinkVC: UIViewController
{
    @IBOutlet weak var hungerSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var quantitySlider: UISlider!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customizeSliders()
        quantityLabel.text = String(drinkList[myIndex].quantity) + " мл"
        volumeLabel.text = String(drinkList[myIndex].minVolume) + "°"
    }
    
    @IBAction func volumeSliderValueChanged(_ sender: UISlider)
    {
        let volumeSliderStep: Float = 1.0
        let currentValue = round(sender.value / volumeSliderStep) * volumeSliderStep
        sender.value = round(currentValue)
        volumeLabel.text = String(Int(volumeSlider.value)) + "°"
    }
    
    @IBAction func quantitySliderValueChanged(_ sender: UISlider)
    {
        let quantitySliderStep: Float = 50.0
        let currentValue = round(sender.value / quantitySliderStep) * quantitySliderStep
        sender.value = round(currentValue)
        quantityLabel.text = String(Int(quantitySlider.value)) + " мл"
    }
    
    @IBAction func hungerSliderValueChanged(_ sender: UISlider)
    {
        let hungerSliderStep: Float = 1.0
        let currentValue = round(sender.value / hungerSliderStep) * hungerSliderStep
        sender.value = round(currentValue)
    }
    
    
    func customizeSliders()
    {
        let quantitySliderStep: Float = 50.0
        let volumeSliderStep: Float = 1.0
        if let maxVolume = drinkList[myIndex].maxVolume
        {
            volumeSlider.isEnabled = true
            quantitySlider.isEnabled = true
            volumeSlider.maximumValue = Float(maxVolume)
            volumeSlider.minimumValue = Float(drinkList[myIndex].minVolume)
            volumeSlider.value = round(Float(drinkList[myIndex].minVolume) / volumeSliderStep) * volumeSliderStep
        }
        else
        {
            volumeSlider.isEnabled = false
        }
        quantitySlider.maximumValue = 1000.0
        quantitySlider.minimumValue = 50.0
        quantitySlider.value = round(Float(drinkList[myIndex].quantity) / quantitySliderStep) * quantitySliderStep
        hungerSlider.maximumValue = 22.0
        hungerSlider.minimumValue = 0.0
        hungerSlider.value = 10.0
    }
    
    // MARK: - Navigation
    @IBAction func cancelButtonTapped(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton)
    {
        let tempQuantity = Int(quantitySlider.value)
        let minVolume = Int(volumeSlider.value)
        let tempDrink: Drink
        if let maxVolume = drinkList[myIndex].maxVolume
        {
            tempDrink = Drink(name: drinkList[myIndex].name, minVolume: minVolume, quantity: tempQuantity, maxVolume: maxVolume, date: datePicker.date, hunger: Int(hungerSlider!.value))
        }
        else
        {
            tempDrink = Drink(name: drinkList[myIndex].name, minVolume: minVolume, quantity: tempQuantity, maxVolume: nil, date: datePicker.date, hunger: Int(hungerSlider!.value))
        }

        drinkNameArray.append(tempDrink.name)
        drinkVolumeArray.append(tempDrink.minVolume)
        drinkQuantityArray.append(tempDrink.quantity)
        drinkDateArray.append(tempDrink.date!)
        drinkHungerArray.append(tempDrink.hunger!)
        print(drinkNameArray, drinkNameArray.count)
        print(drinkVolumeArray, drinkVolumeArray.count)
        print(drinkQuantityArray, drinkQuantityArray.count)
        UserDefaults.standard.set(drinkNameArray, forKey: "settingsDrinkNameArray")
        UserDefaults.standard.set(drinkVolumeArray, forKey: "settingsDrinkVolumeArray")
        UserDefaults.standard.set(drinkQuantityArray, forKey: "settingsDrinkQuantityArray")
        UserDefaults.standard.set(drinkDateArray, forKey: "settingsDrinkDateArray")
        UserDefaults.standard.set(drinkHungerArray, forKey: "settingsDrinkHungerArray")
        navigationController?.popViewController(animated: true)
    }
}
