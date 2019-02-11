//
//  AlcoListVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 08.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

struct Drink
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


class AlcoListVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    var drinkList: [Drink] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fillArrays()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
    }
    
    func fillArrays()
    {
        drinkList.append(Drink(name: "Пиво", volume: 4.0, quantity: 500))
        drinkList.append(Drink(name: "Шампанское", volume: 5.0, quantity: 200))
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
        drinkList.append(Drink(name: "Текила", volume: 40.0, quantity: 40))
        drinkList.append(Drink(name: "Мартини", volume: 15.0, quantity: 200))
        drinkList.append(Drink(name: "Настойка", volume: 20.0, quantity: 40))
        drinkList.append(Drink(name: "Алкогольный", volume: 6.0, quantity: 200))
        drinkList.append(Drink(name: "Сидр", volume: 5.0, quantity: 500))
        drinkList.append(Drink(name: "Эль", volume: 5.0, quantity: 500))
    }
    
    // MARK: - Navigation
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
        cell.alcoholQuantityLabel.textColor = UIColor.red
        cell.alcoholVolumeLabel.text = String(drinkList[indexPath.row].volume) + "%"
        return cell
    }
    
    @objc func cancelTapped()
    {
        
    }
}
