//
//  PromilleCalculator.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 17.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import Foundation

var last3DaysDrinkArray: [Drink] = []

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
    
    func addDays(daysToAdd: Int) -> NSDate
    {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays) as NSDate
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate
    {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours) as NSDate
        return dateWithHoursAdded
    }
}


class PromilleCalculator
{
    var rCoef: Double = 0
    var weight: Int = 0
    var alcoholConsumed: Double = 0
    
    func fillLast3DaysDrinkArray()
    {
        var date3DaysAgo = Date(timeIntervalSinceNow: 0) //3 days ago
        date3DaysAgo = date3DaysAgo.addDays(daysToAdd: -3) as Date
        print(date3DaysAgo)
        print("drinkDateArray \(drinkDateArray)")
        
        for i in 0...drinkDateArray.count
        {
            //if (drinkDateArray[i] > date3DaysAgo)
            //if (drinkDateArray[i].isGreaterThanDate(dateToCompare: date3DaysAgo))
            //{
            //    last3DaysDrinkArray.append(Drink(name: drinkNameArray[i], minVolume: drinkVolumeArray[i], quantity: drinkQuantityArray[i], maxVolume: nil, date: drinkDateArray[i]))
            //}
        }
        print(last3DaysDrinkArray)
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
        //let hungerCoef =
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
