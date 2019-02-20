//
//  StateVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 06.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

let calc = PromilleCalculator()

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
        calc.rCoef = 0.7
        calc.weight = 60
        let circle = CircleView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        circle.center = CGPoint(x: view.center.x, y: view.frame.height/5)
        promilleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        promilleLabel.center = circle.center
        promilleLabel.textAlignment = .center
        promilleLabel.font = promilleLabel.font.withSize(40)
        promilleLabel.textColor = UIColor.black
        self.view.addSubview(circle)
        self.view.addSubview(promilleLabel)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if drinkNameArray.count == 0
        {
            sobrietyLabel.text = "Для более точного расчета количества алкоголя в крови требуется ввести свои данные в настройках"
            promilleLabel.text = "0.0‰"
        }
        else
        {
            calc.fillLast3DaysDrinkArray()
            var result = calc.calculatePromille()
            result = calc.recalculatePromilleWithHours(currentPromilles: result)
            let timeLeft = calc.timeLeft(promilleNumber: result)
            promilleLabel.text = String(result) + "‰"
            if result == 0.0
            {
                sobrietyLabel.text = "Вы трезвы"
            }
            else if result >= 0.1 && result <= 0.35
            {
                
                sobrietyLabel.text = "Концентрация алкоголя в крови в пределах допустимой нормы в 0.35‰. Можно садиться за руль. До полного выведения алкоголя из организма осталось \(timeLeft) часов"
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

    // MARK: - Navigation

}
