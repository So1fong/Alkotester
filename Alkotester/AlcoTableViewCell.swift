//
//  AlcoTableViewCell.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 09.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

class AlcoTableViewCell: UITableViewCell
{
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var alcoholVolumeLabel: UILabel!
    @IBOutlet weak var alcoholQuantityLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
