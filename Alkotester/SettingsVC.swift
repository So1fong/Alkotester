//
//  SettingsVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 06.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController
{
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var heightPicker: UIPickerView!
    @IBOutlet weak var weightPicker: UIPickerView!
    var genderPickerData = ["Мужской", "Женский"]
    var heightPickerData: [String] = []
    var weightPickerData: [String] = []
    var indexedItem = 0
    var indexedGender = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initializePickers()
        loadSettings()

    }
    
    //MARK: - Инициализация Picker View's
    
    func initializePickers()
    {
        genderPicker.delegate = self
        genderPicker.dataSource = self
        setHeightPickerData()
        heightPicker.delegate = self
        heightPicker.dataSource = self
        setWeightPickerData()
        weightPicker.delegate = self
        weightPicker.dataSource = self
        //выбрать по умолчанию значения: рост 170 см, вес 60 кг
        heightPicker.selectRow(30, inComponent: 0, animated: false)
        weightPicker.selectRow(30, inComponent: 0, animated: false)
    }
    
    func setHeightPickerData()
    {
        for i in 140...210
        {
            heightPickerData.append(String(i))
        }
    }
    
    func setWeightPickerData()
    {
        for i in 30...200
        {
            weightPickerData.append(String(i))
        }
    }

    func loadSettings()
    {
        var row = 0
        if let gender = UserDefaults.standard.string(forKey: "selectedCurrencyInGenderPicker")
        {
            print("row value " + gender)
            switch gender
            {
            case "Мужской":
                print("case 0")
                genderPicker.selectRow(0, inComponent: 0, animated: false)
            case "Женский":
                print("case 1")
                genderPicker.selectRow(1, inComponent: 0, animated: false)
            default:
                break
            }
        }
        row = UserDefaults.standard.integer(forKey: "selectedCurrencyInHeightPicker")
        heightPicker.selectRow(row, inComponent: 0, animated: false)
        row = UserDefaults.standard.integer(forKey: "selectedCurrencyInWeightPicker")
        weightPicker.selectRow(row, inComponent: 0, animated: false)
    }


}


// MARK: - Расширение
extension SettingsVC: UIPickerViewDelegate, UIPickerViewDataSource
{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerView
        {
        case genderPicker:
            return genderPickerData.count
        case heightPicker:
            return heightPickerData.count
        case weightPicker:
            return weightPickerData.count
        default:
            return 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView
        {
        case genderPicker:
            return genderPickerData[row]
        case heightPicker:
            return heightPickerData[row]
        case weightPicker:
            return weightPickerData[row]
        default:
            return "0"
        }
    }
    
     public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
     {
        switch pickerView
        {
        case genderPicker:
                let temp = String(genderPickerData[row])
                print("selected row gender " + genderPickerData[row] + " row " + String(row))
                indexedGender = temp
                print("indexedGender " + indexedGender)
                UserDefaults.standard.set(indexedGender, forKey: "selectedCurrencyInGenderPicker")
        case heightPicker:
            if let temp = Int(heightPickerData[row])
            {
                print(heightPickerData[row])
                indexedItem = temp
                UserDefaults.standard.set(row, forKey: "selectedCurrencyInHeightPicker")
            }
        case weightPicker:
            if let temp = Int(weightPickerData[row])
            {
                indexedItem = temp
                UserDefaults.standard.set(row, forKey: "selectedCurrencyInWeightPicker")
            }
        default:
            break
        }
     }
}
