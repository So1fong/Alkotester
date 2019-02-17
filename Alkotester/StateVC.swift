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
        let circle = CircleView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        circle.center = CGPoint(x: view.center.x, y: view.frame.height/5)
        let promilleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        promilleLabel.center = circle.center
        promilleLabel.text = "0.0‰"
        promilleLabel.textAlignment = .center
        promilleLabel.font = promilleLabel.font.withSize(45)
        promilleLabel.textColor = UIColor.black
        self.view.addSubview(circle)
        self.view.addSubview(promilleLabel)
        let calc = PromilleCalculator()
        calc.getCoefficient()
        calc.getWeight()
        calc.alcoholConsumed = 500*0.08
        let result = calc.calculatePromille()
        //полный желудок дает -22% от итогового промилле
        print("promille \(result)")
        let timeLeft = calc.timeLeft()
        print("time left \(timeLeft) hrs")
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

    }
    // MARK: - Navigation

}
