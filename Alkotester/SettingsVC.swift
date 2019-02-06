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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initializePickers()

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

    
    // MARK: - Расширение

}

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
}
