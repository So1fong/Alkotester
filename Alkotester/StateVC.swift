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
    @IBOutlet weak var sobrietyLabel: UILabel!
    var promilleLabel = UILabel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customizeAddButton()
        hideNavigationBar()
        //sobrietyLabel.sizeToFit()
        let circle = CircleView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        circle.center = CGPoint(x: view.center.x, y: view.frame.height/5)
        promilleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        promilleLabel.center = circle.center

        promilleLabel.textAlignment = .center
        promilleLabel.font = promilleLabel.font.withSize(45)
        promilleLabel.textColor = UIColor.black
        self.view.addSubview(circle)
        self.view.addSubview(promilleLabel)

        //полный желудок дает -22% от итогового промилле
        //print("promille \(result)")
        //допустимый диапазон промилле -- 0.0-0.16
        //алкоголь держится в крови максимум 3 дня


    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if drinkNameArray.count == 0
        {
            sobrietyLabel.text = "Пожалуйста, введите свои данные и добавьте напитки для расчета количества алкоголя в крови"
            promilleLabel.text = "0.0‰"
        }
        else
        {
            let calc = PromilleCalculator()
            calc.fillLast3DaysDrinkArray()
            let result = calc.calculatePromille()
            let timeLeft = calc.timeLeft()
            promilleLabel.text = String(result) + "‰"
            if result >= 0.0 && result <= 0.16
            {
                sobrietyLabel.text = "Вы трезвы"
            }
            else
            {
                sobrietyLabel.text = "До полного выведения алкоголя из организма осталось \(timeLeft) часов"
            }
            
            
        }

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
