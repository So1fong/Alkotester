//
//  AlcoListVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 08.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

class AlcoListVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    var alcoArray: [String] = []
    var alcoVolumeArray: [String] = []
    var alcoQuantityArray: [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fillArrays()
        tableView.delegate = self
        tableView.dataSource = self
        print(alcoVolumeArray.count, alcoArray.count, alcoQuantityArray.count)
    }
    
    func fillArrays()
    {
        alcoArray = ["Пиво", "Шампанское", "Вино", "Водка", "Виски", "Ром", "Джин", "Коньяк", "Ликер", "Сакэ", "Бренди", "Абсент", "Самбука", "Текила", "Мартини", "Настойка", "Алкогольный коктейль", "Сидр", "Эль"]
        alcoVolumeArray = ["4.0", "5.0", "12.0", "40.0", "40.0", "40.0", "40.0", "40.0", "40.0", "20.0", "40.0", "70.0", "40.0", "40.0", "15.0", "20.0", "6.0", "5.0", "5.0"]
        alcoQuantityArray = ["500", "200", "200", "40", "40", "40", "40", "40", "40", "40", "40", "40", "40", "40", "200", "40", "200", "500", "500"]
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (alcoArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlcoTableViewCell else
        {
            fatalError("Could not dequeue cell")
        }
        print(alcoArray[indexPath.row])
        cell.drinkNameLabel.text = alcoArray[indexPath.row]
        cell.alcoholQuantityLabel.text = alcoQuantityArray[indexPath.row]
        cell.alcoholVolumeLabel.text = alcoVolumeArray[indexPath.row]
        return cell
    }
    
    @objc func cancelTapped()
    {
        
    }
}
