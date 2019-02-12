//
//  HistoryTableViewCell.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 12.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell
{

    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkVolumeLabel: UILabel!
    @IBOutlet weak var drinkQuantityLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
