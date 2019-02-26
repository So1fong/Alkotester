//
//  HistoryVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 06.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var timeIntervalDrinkArray: [Drink] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return timeIntervalDrinkArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryTableViewCell else
        {
            fatalError("Could not dequeue cell")
        }
        historyCell.drinkNameLabel.text = timeIntervalDrinkArray[indexPath.row].name
        historyCell.drinkQuantityLabel.text = String(timeIntervalDrinkArray[indexPath.row].quantity) + " мл"
        historyCell.drinkVolumeLabel.text = String(timeIntervalDrinkArray[indexPath.row].minVolume) + "%"
        let yellow = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        switch timeIntervalDrinkArray[indexPath.row].minVolume
        {
        case 0..<10:
            historyCell.drinkVolumeLabel.textColor = UIColor.green
        case 10..<20:
            historyCell.drinkVolumeLabel.textColor = yellow
        case 20..<30:
            historyCell.drinkVolumeLabel.textColor = UIColor.orange
        case 30...100:
            historyCell.drinkVolumeLabel.textColor = UIColor.red
        default:
            break
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        if let date = timeIntervalDrinkArray[indexPath.row].date
        {
            historyCell.drinkDateLabel.text = formatter.string(from: date)
        }
        
        return historyCell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить", handler:
        {
            (action, indexPath) in
            print(drinkNameArray, drinkNameArray.count)
            print(drinkQuantityArray, drinkQuantityArray.count)
            print(drinkVolumeArray, drinkVolumeArray.count)
            var date3DaysAgo = Date(timeIntervalSinceNow: 0) // now
            date3DaysAgo = date3DaysAgo.addDays(daysToAdd: -3) // 3 days ago
            let tempDrink = Drink(name: drinkNameArray[indexPath.row], minVolume: drinkVolumeArray[indexPath.row],
                                  quantity: drinkQuantityArray[indexPath.row], maxVolume: 0,
                                  date: drinkDateArray[indexPath.row], hunger: drinkHungerArray[indexPath.row])
            if drinkDateArray[indexPath.row].isGreaterThanDate(dateToCompare: date3DaysAgo) &&
                !last3DaysDrinkArray.contains(where: {$0 == tempDrink})
            {
                if let index = last3DaysDrinkArray.firstIndex(of: tempDrink)
                {
                    last3DaysDrinkArray.remove(at: index)
                }
            }
            if let index = self.timeIntervalDrinkArray.firstIndex(of: tempDrink)
            {
                self.timeIntervalDrinkArray.remove(at: index)
            }
            drinkNameArray.remove(at: indexPath.row)
            drinkQuantityArray.remove(at: indexPath.row)
            drinkVolumeArray.remove(at: indexPath.row)
            drinkDateArray.remove(at: indexPath.row)
            drinkHungerArray.remove(at: indexPath.row)

            print(drinkNameArray, drinkNameArray.count)
            print(drinkQuantityArray, drinkQuantityArray.count)
            print(drinkVolumeArray, drinkVolumeArray.count)
            
            UserDefaults.standard.set(drinkNameArray, forKey: "settingsDrinkNameArray")
            UserDefaults.standard.set(drinkVolumeArray, forKey: "settingsDrinkVolumeArray")
            UserDefaults.standard.set(drinkQuantityArray, forKey: "settingsDrinkQuantityArray")
            UserDefaults.standard.set(drinkDateArray, forKey: "settingsDrinkDateArray")
            UserDefaults.standard.set(drinkHungerArray, forKey: "settingsDrinkHungerArray")
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        return [delete]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55
        segmentedControl.selectedSegmentIndex = 0
        //var dayAgo = Date(timeIntervalSinceNow: 0)
        //dayAgo = dayAgo.addDays(daysToAdd: -1)
        //fillTimeIntervalDrinkArray(dateToCompate: dayAgo)
        //segmentedControlValueChanged(segmentedControl)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    func fillTimeIntervalDrinkArray(dateToCompate: Date?)
    {
        timeIntervalDrinkArray = []
        let now = Date(timeIntervalSinceNow: 0)
        if drinkDateArray.count == 0
        {
            return
        }
        for i in 0...drinkDateArray.count-1
        {
            if let date = dateToCompate
            {
                if drinkDateArray[i].isLessThanDate(dateToCompare: now) && drinkDateArray[i].isGreaterThanDate(dateToCompare: date)
                {
                    timeIntervalDrinkArray.append(Drink(name: drinkNameArray[i], minVolume: drinkVolumeArray[i], quantity: drinkQuantityArray[i], maxVolume: 0, date: drinkDateArray[i], hunger: drinkHungerArray[i]))
                }
            }
            else
            {
                if drinkDateArray[i].isLessThanDate(dateToCompare: now)
                {
                   timeIntervalDrinkArray.append(Drink(name: drinkNameArray[i], minVolume: drinkVolumeArray[i], quantity: drinkQuantityArray[i], maxVolume: 0, date: drinkDateArray[i], hunger: drinkHungerArray[i]))
                }
            }
        }
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            var dayAgo = Date(timeIntervalSinceNow: 0)
            dayAgo = dayAgo.addDays(daysToAdd: -1)
            fillTimeIntervalDrinkArray(dateToCompate: dayAgo)
        case 1:
            var weekAgo = Date(timeIntervalSinceNow: 0)
            weekAgo = weekAgo.addDays(daysToAdd: -7)
            fillTimeIntervalDrinkArray(dateToCompate: weekAgo)
        case 2:
            var monthAgo = Date(timeIntervalSinceNow: 0)
            monthAgo = monthAgo.addDays(daysToAdd: -30)
            fillTimeIntervalDrinkArray(dateToCompate: monthAgo)
        case 3:
            fillTimeIntervalDrinkArray(dateToCompate: nil)
        default:
            break
        }
        tableView.reloadData()
    }
    // MARK: - Navigation


}
