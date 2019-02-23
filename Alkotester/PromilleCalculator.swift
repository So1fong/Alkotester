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
    
    @discardableResult func addDays(daysToAdd: Int) -> Date
    {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    
    @discardableResult func addHours(hoursToAdd: Int) -> Date
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
        for i in 0...160
        {
            if i == index
            {
                weight = i + 40
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
    
    @discardableResult func calculatePromille(forDrink: Drink) -> Double
    {
        //формула Видмарка
        getWeight()
        getCoefficient()
        let hungerCoef = 1.0 - (Double(forDrink.hunger!) / 100)
        alcoholConsumed = (Double(forDrink.quantity) * Double(forDrink.minVolume) * hungerCoef) / 100
        currentState = (self.alcoholConsumed / (Double(weight) * rCoef)) * 0.8
        print(currentState)
        return currentState
    }
    
    func timeLeft(promilleNumber: Double) -> Double
    {
        alcoholConsumed = 0
        var timeLeft = promilleNumber / 0.15
        timeLeft = Double(round(10 * timeLeft) / 10) //округление до 1 знака после запятой
        return timeLeft
        
        
    }
    
    func recalculatePromilleWithHours(currentPromilles: Double) -> Double
    {
        var earliestDate = Date(timeIntervalSinceNow: 0)
        for i in 0...last3DaysDrinkArray.count-1
        {
            if let date = last3DaysDrinkArray[i].date
            {
                earliestDate = min(date, earliestDate)
            }
        }
        var timePassed = abs(earliestDate.timeIntervalSinceNow)
        //print("timePassed \(timePassed)")
        var newPromilles = 0.0
        while timePassed > 0
        {
            timePassed -= 240
            newPromilles = currentPromilles - 0.01
        }
        newPromilles = Double(round(100 * newPromilles) / 100)
        //print("new promilles = \(newPromilles)")
        return newPromilles
    }
}
