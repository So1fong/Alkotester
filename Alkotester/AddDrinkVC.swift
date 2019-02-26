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
var drink = Drink()

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
        if isFiltering
        {
            drink = filteredDrinks[myIndex]
        }
        else
        {
            drink = drinkList[myIndex]
        }
        customizeSliders()
        quantityLabel.text = String(drink.quantity) + " мл"
        volumeLabel.text = String(drink.minVolume) + "°"
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
        
        if let maxVolume = drink.maxVolume
        {
            volumeSlider.isEnabled = true
            quantitySlider.isEnabled = true
            volumeSlider.maximumValue = Float(maxVolume)
            volumeSlider.minimumValue = Float(drink.minVolume)
            volumeSlider.value = round(Float(drink.minVolume) / volumeSliderStep) * volumeSliderStep
        }
        else
        {
            volumeSlider.isEnabled = false
        }
        quantitySlider.maximumValue = 1000.0
        quantitySlider.minimumValue = 50.0
        quantitySlider.value = round(Float(drink.quantity) / quantitySliderStep) * quantitySliderStep
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
        if let maxVolume = drink.maxVolume
        {
            tempDrink = Drink(name: drink.name, minVolume: minVolume, quantity: tempQuantity, maxVolume: maxVolume, date: datePicker.date, hunger: Int(hungerSlider!.value))
        }
        else
        {
            tempDrink = Drink(name: drink.name, minVolume: drink.minVolume, quantity: tempQuantity, maxVolume: nil, date: datePicker.date, hunger: Int(hungerSlider!.value))
        }
        drinkNameArray.append(tempDrink.name)
        drinkVolumeArray.append(tempDrink.minVolume)
        drinkQuantityArray.append(tempDrink.quantity)
        drinkDateArray.append(tempDrink.date!)
        drinkHungerArray.append(tempDrink.hunger!)
        UserDefaults.standard.set(drinkNameArray, forKey: "settingsDrinkNameArray")
        UserDefaults.standard.set(drinkVolumeArray, forKey: "settingsDrinkVolumeArray")
        UserDefaults.standard.set(drinkQuantityArray, forKey: "settingsDrinkQuantityArray")
        UserDefaults.standard.set(drinkDateArray, forKey: "settingsDrinkDateArray")
        UserDefaults.standard.set(drinkHungerArray, forKey: "settingsDrinkHungerArray")
        navigationController?.popViewController(animated: true)
    }
}
