//
//  PromilleCalculator.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 17.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import Foundation

class PromilleCalculator
{
    var rCoef: Double = 0
    var weight: Int = 0
    var alcoholConsumed: Double = 0
    
    
    func getWeight()
    {
        let index = UserDefaults.standard.integer(forKey: "selectedCurrencyInWeightPicker")
        for i in 0...170
        {
            if i == index
            {
                weight = i + 30
            }
        }
        print(weight)
    }
    
    func getCoefficient()
    {
        if let gender = UserDefaults.standard.string(forKey: "selectedCurrencyInGenderPicker")
        {
            switch gender
            {
            case "Мужской":
                rCoef = 0.7
            case "Женский":
                rCoef = 0.6
            default:
                break
            }
        }
        print(rCoef)
    }
    
    func calculatePromille() -> Double
    {
        //формула Видмарка
        var result = (self.alcoholConsumed / (Double(self.weight) * self.rCoef)) * 0.8
        result = Double(round(10 * result) / 10) //округление до 1 знака после запятой
        return result
    }
    
    func timeLeft() -> Double
    {
        var timeLeft = calculatePromille() / 0.15
        timeLeft = Double(round(10 * timeLeft) / 10) //округление до 1 знака после запятой
        return timeLeft
    }
}
