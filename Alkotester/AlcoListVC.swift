//
//  AlcoListVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 08.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

// MARK: - Объявление структуры
var drinkList: [Drink] = []
var myIndex = 0

struct Drink: Codable
{
    var name: String
    var minVolume: Int
    var quantity: Int
    var maxVolume: Int?
    var date: Date?
    var hunger: Int?
    
    init(name: String, minVolume: Int, quantity: Int)
    {
        self.name = name
        self.minVolume = minVolume
        self.quantity = quantity
        self.maxVolume = nil
        self.date = nil
        self.hunger = nil
    }
    
    init(name: String, minVolume: Int, quantity: Int, maxVolume: Int?)
    {
        self.name = name
        self.minVolume = minVolume
        self.quantity = quantity
        self.maxVolume = maxVolume
        self.date = nil
        self.hunger = nil
    }
    
    init(name: String, minVolume: Int, quantity: Int, maxVolume: Int?, date: Date?, hunger: Int?)
    {
        self.name = name
        self.minVolume = minVolume
        self.quantity = quantity
        self.maxVolume = maxVolume
        self.date = date
        self.hunger = hunger
    }
}

extension Drink: Equatable
{
    static func == (lhs: Drink, rhs: Drink) -> Bool
    {
        return lhs.name == rhs.name &&
               lhs.maxVolume == rhs.maxVolume &&
               lhs.minVolume == rhs.minVolume &&
               lhs.date == rhs.date &&
               lhs.quantity == rhs.quantity &&
               lhs.hunger == rhs.hunger
    }

    static func != (lhs: Drink, rhs: Drink) -> Bool
    {
        return lhs.name != rhs.name ||
               lhs.maxVolume != rhs.maxVolume ||
               lhs.minVolume != rhs.minVolume ||
               lhs.date != rhs.date ||
               lhs.quantity != rhs.quantity ||
               lhs.hunger != rhs.hunger
    }
}

class AlcoListVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fillArrays()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
    }
    
    // MARK: - Заполнение массива структур
    func fillArrays()
    {
        drinkList.append(Drink(name: "Сидр", minVolume: 2, quantity: 500, maxVolume: 7)) //2-7
        drinkList.append(Drink(name: "Алкогольный коктейль", minVolume: 4, quantity: 200, maxVolume: 12)) //4-12
        drinkList.append(Drink(name: "Пиво", minVolume: 4, quantity: 500, maxVolume: 14)) //4-14
        drinkList.append(Drink(name: "Эль", minVolume: 5, quantity: 500, maxVolume: 7))
        drinkList.append(Drink(name: "Шампанское", minVolume: 8, quantity: 200, maxVolume: 13)) //8-13
        drinkList.append(Drink(name: "Вино", minVolume: 9, quantity: 200, maxVolume: 22)) //9-22
        drinkList.append(Drink(name: "Ликер", minVolume: 15, quantity: 50, maxVolume: 40))
        drinkList.append(Drink(name: "Сакэ", minVolume: 15, quantity: 50, maxVolume: 20)) //15-20
        drinkList.append(Drink(name: "Мартини", minVolume: 16, quantity: 200))
        drinkList.append(Drink(name: "Вермут", minVolume: 16, quantity: 100, maxVolume: 18))
        drinkList.append(Drink(name: "Портвейн", minVolume: 17, quantity: 100, maxVolume: 20))
        drinkList.append(Drink(name: "Наливка", minVolume: 18, quantity: 50, maxVolume: 20))
        drinkList.append(Drink(name: "Настойка", minVolume: 20, quantity: 50, maxVolume: 45))
        drinkList.append(Drink(name: "Лимончелло", minVolume: 30, quantity: 50, maxVolume: 43))
        drinkList.append(Drink(name: "Ром", minVolume: 30, quantity: 50, maxVolume: 78)) //30-78
        drinkList.append(Drink(name: "Текила", minVolume: 35, quantity: 50, maxVolume: 55)) //35-55
        drinkList.append(Drink(name: "Джин", minVolume: 38, quantity: 50, maxVolume: 45)) //38-45
        drinkList.append(Drink(name: "Самбука", minVolume: 38, quantity: 50, maxVolume: 42)) //38-42
        drinkList.append(Drink(name: "Бренди", minVolume: 40, quantity: 50))
        drinkList.append(Drink(name: "Бурбон", minVolume: 40, quantity: 50, maxVolume: 50))
        drinkList.append(Drink(name: "Виски", minVolume: 40, quantity: 50, maxVolume: 50)) //40-50
        drinkList.append(Drink(name: "Водка", minVolume: 40, quantity: 50)) //40
        drinkList.append(Drink(name: "Коньяк", minVolume: 40, quantity: 50))
        drinkList.append(Drink(name: "Ликер", minVolume: 40, quantity: 50))
        drinkList.append(Drink(name: "Самогон", minVolume: 40, quantity: 50))
        drinkList.append(Drink(name: "Чача", minVolume: 45, quantity: 50, maxVolume: 60))
        drinkList.append(Drink(name: "Абсент", minVolume: 70, quantity: 50, maxVolume: 86)) //70-86
    }
    
    // MARK: - Логика ячеек таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (drinkList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlcoTableViewCell else
        {
            fatalError("Could not dequeue cell")
        }
        cell.drinkNameLabel.text = drinkList[indexPath.row].name
        cell.alcoholQuantityLabel.text = String(drinkList[indexPath.row].quantity) + " мл"
        if let maxVolume = drinkList[indexPath.row].maxVolume
        {
            cell.alcoholVolumeLabel.text = String(drinkList[indexPath.row].minVolume) + "-" + String(maxVolume) + "%"
        }
        else
        {
            cell.alcoholVolumeLabel.text = String(drinkList[indexPath.row].minVolume) + "%"
        }
        switch drinkList[indexPath.row].minVolume
        {
        case 0..<10:
            cell.alcoholVolumeLabel.textColor = UIColor.green
        case 10..<20:
            cell.alcoholVolumeLabel.textColor = UIColor.yellow
        case 20..<30:
            cell.alcoholVolumeLabel.textColor = UIColor.orange
        case 30...100:
            cell.alcoholVolumeLabel.textColor = UIColor.red
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
    }
}
