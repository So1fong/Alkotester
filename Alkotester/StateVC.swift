//
//  StateVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 06.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

class StateVC: UIViewController
{

    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customizeAddButton()
        hideNavigationBar()
    }
    
    func hideNavigationBar()
    {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func customizeAddButton()
    {
        addButton.layer.masksToBounds = false
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 1.0
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }

    @IBAction func addButtonTapped(_ sender: UIButton)
    {
        UIView.animate(withDuration: 0.2, animations: { self.addButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)},
                       completion:
            { _ in UIView.animate(withDuration: 0.2, animations:
                {
                    self.addButton.transform = CGAffineTransform.identity}
                                  )
            }
                    )
    }
    // MARK: - Navigation

}
