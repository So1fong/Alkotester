//
//  PromilleCalculator.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 17.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import Foundation

extension Date
{
    func isGreaterThanDate(dateToCompare: Date) -> Bool
    {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending
        {
            isGreater = true
        }
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool
    {
        var isLess = false
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending
        {
            isLess = true
        }
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool
    {
        var isEqualTo = false
        if self.compare(dateToCompare) == ComparisonResult.orderedSame
        {
            isEqualTo = true
        }
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> Date
    {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> Date
    {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
}

var last3DaysDrinkArray: [Drink] = []

class PromilleCalculator
{
    var rCoef: Double = 0
    var weight: Int = 0
    var alcoholConsumed: Double = 0
    
    func fillLast3DaysDrinkArray()
    {
        if (drinkNameArray.count > 0)
        {
            var date3DaysAgo = Date(timeIntervalSinceNow: 0) // now
            date3DaysAgo = date3DaysAgo.addDays(daysToAdd: -3) // 3 days ago
            var tempDrink: Drink
            for i in 0...drinkDateArray.count-1
            {
                tempDrink = Drink(name: drinkNameArray[i], minVolume: drinkVolumeArray[i],
                                 quantity: drinkQuantityArray[i], maxVolume: 0,
                                 date: drinkDateArray[i], hunger: drinkHungerArray[i])
                if last3DaysDrinkArray.count == 0
                {
                    last3DaysDrinkArray.append(tempDrink)
                }
                else
                {
                    if drinkDateArray[i].isGreaterThanDate(dateToCompare: date3DaysAgo) &&
                    !last3DaysDrinkArray.contains(where: {$0 == tempDrink})
                    {
                        last3DaysDrinkArray.append(tempDrink)
                    }
                }
            }
        }
    }
    
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
    }
    
    func calculatePromille() -> Double
    {
        //формула Видмарка
        print(last3DaysDrinkArray, last3DaysDrinkArray.count)
        getWeight()
        getCoefficient()
        for i in 0...last3DaysDrinkArray.count-1
        {
            alcoholConsumed += Double(last3DaysDrinkArray[i].quantity * last3DaysDrinkArray[i].minVolume) / 100
        }
        print("alcoholConsumed \(alcoholConsumed)")
        var result = (self.alcoholConsumed / (Double(self.weight) * self.rCoef)) * 0.8
        //let hungerCoef =
        result = Double(round(10 * result) / 10) //округление до 1 знака после запятой
        print("result \(result)")
        return result
    }
    
    func timeLeft() -> Double
    {
        alcoholConsumed = 0
        var timeLeft = calculatePromille() / 0.15
        timeLeft = Double(round(10 * timeLeft) / 10) //округление до 1 знака после запятой
        return timeLeft
    }
}
