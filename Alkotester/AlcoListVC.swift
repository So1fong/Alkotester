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
    var volume: Double
    var quantity: Int
    
    init(name: String, volume: Double, quantity: Int)
    {
        self.name = name
        self.volume = volume
        self.quantity = quantity
    }
}

func save(_ drinks: [Drink])
{
    let data = drinks.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "historyDrinkList")
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
        drinkList.append(Drink(name: "Пиво", volume: 5.4, quantity: 500))
        drinkList.append(Drink(name: "Шампанское", volume: 13.0, quantity: 200))
        drinkList.append(Drink(name: "Вино", volume: 12.0, quantity: 200))
        drinkList.append(Drink(name: "Водка", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Виски", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Ром", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Джин", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Коньяк", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Ликер", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Сакэ", volume: 20.0, quantity: 40))
        drinkList.append(Drink(name: "Бренди", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Абсент", volume: 70.0, quantity: 40))
        drinkList.append(Drink(name: "Самбука", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Текила", volume: 38.0, quantity: 40))
        drinkList.append(Drink(name: "Мартини", volume: 16.0, quantity: 200))
        drinkList.append(Drink(name: "Настойка", volume: 20.0, quantity: 40))
        drinkList.append(Drink(name: "Алкогольный коктейль", volume: 8.7, quantity: 200))
        drinkList.append(Drink(name: "Сидр", volume: 7.0, quantity: 500))
        drinkList.append(Drink(name: "Эль", volume: 5.5, quantity: 500))
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
        cell.alcoholVolumeLabel.text = String(drinkList[indexPath.row].volume) + "%"
        switch drinkList[indexPath.row].volume
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
    
    @objc func cancelTapped()
    {
        
    }
}
