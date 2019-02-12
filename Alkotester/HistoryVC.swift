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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return drinkNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryTableViewCell else
        {
            fatalError("Could not dequeue cell")
        }
        cell.drinkNameLabel.text = drinkNameArray[indexPath.row]
        cell.drinkQuantityLabel.text = String(drinkQuantityArray[indexPath.row]) + " мл"
        cell.drinkVolumeLabel.text = String(drinkVolumeArray[indexPath.row]) + "%"
        switch drinkVolumeArray[indexPath.row]
        {
        case 0..<10:
            cell.drinkVolumeLabel.textColor = UIColor.green
        case 10..<20:
            cell.drinkVolumeLabel.textColor = UIColor.yellow
        case 20..<30:
            cell.drinkVolumeLabel.textColor = UIColor.orange
        case 30...100:
            cell.drinkVolumeLabel.textColor = UIColor.red
        default:
            break
        }
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.reloadData()
    }
    


    // MARK: - Navigation


}
