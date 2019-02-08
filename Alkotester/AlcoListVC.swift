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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return alcoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = alcoArray[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    var alcoArray = ["Пиво", "Шампанское", "Вино", "Водка", "Виски", "Ром", "Джин", "Коньяк", "Ликер", "Сакэ", "Бренди", "Абсент", "Самбука", "Текила", "Мартини", "Настойка", "Наливка", "Алкогольный коктейль", "Сидр", "Эль"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        //navigationItem.leftBarButtonIte
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
    }
    // MARK: - Navigation

    @objc func cancelTapped()
    {
        
    }
}
