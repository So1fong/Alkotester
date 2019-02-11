//
//  AddDrinkVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 11.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

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
        if let quantity = Int(quantityTextField.text!)
        {
            print("ok")
        }
        // проверка введенного значения крепости напитка
        if let volume = Double(volumeTextField.text!)
        {
            if (volume < 0 || volume > 100)
            {
                volumeTextField.text = ""
            }
        }
        let historyList = UserDefaults.standard.array(forKey: "historyList")
        var tempDrink: Drink
        //tempDrink = Drink(name: drinkList[myIndex].name, volume: Double(volumeTextField.text), quantity: Int(quantityTextField.text))
        //print(tempDrink)
    }
    
}
