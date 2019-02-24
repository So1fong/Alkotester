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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return drinkNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryTableViewCell else
        {
            fatalError("Could not dequeue cell")
        }
        historyCell.drinkNameLabel.text = drinkNameArray[indexPath.row]
        historyCell.drinkQuantityLabel.text = String(drinkQuantityArray[indexPath.row]) + " мл"
        historyCell.drinkVolumeLabel.text = String(drinkVolumeArray[indexPath.row]) + "%"
        let yellow = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        switch drinkVolumeArray[indexPath.row]
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
        historyCell.drinkDateLabel.text = formatter.string(from: drinkDateArray[indexPath.row])
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
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }

    // MARK: - Navigation


}
