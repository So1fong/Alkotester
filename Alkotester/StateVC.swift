//
//  StateVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 06.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

let calc = PromilleCalculator()
var currentState: Double = 0
var drinkDictionary: [Int : Double] = [:]
let promilleLoss = 0.15 / 60 / 12
var timer: Timer = Timer()

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
        promilleLabel.textColor = UIColor.black
        promilleLabel.font = promilleLabel.font.withSize(32)
        self.view.addSubview(circle)
        self.view.addSubview(promilleLabel)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        calc.fillLast3DaysDrinkArray()
        print(last3DaysDrinkArray, last3DaysDrinkArray.count)
        fillDrinkDictionary()
        if drinkNameArray.count == 0
        {
            sobrietyLabel.text = "Для более точного расчета количества алкоголя в крови требуется ввести свои данные в настройках"
            promilleLabel.text = "0.0‰"
        }
        else
        {
            updatePromille()
        }
        timer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(updateInfoWithTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        timer.invalidate()
    }
    
    @objc func updateInfoWithTimer()
    {
        fillDrinkDictionary()
        updatePromille()
    }
    
    func fillDrinkDictionary()
    {
        drinkDictionary = [:]
        if last3DaysDrinkArray.count != 0
        {
            for i in 0...last3DaysDrinkArray.count-1
            {
                let timePassed = abs(last3DaysDrinkArray[i].date!.timeIntervalSinceNow)
                let minutes = timePassed / 60
                var hours = minutes / 60
                hours = round(minutes)
                if hours <= 72 * 60
                {
                    var promille = calc.calculatePromille(forDrink: last3DaysDrinkArray[i])
                    if drinkDictionary[Int(hours)] != 0 && drinkDictionary[Int(hours)] != nil
                    {
                        promille += drinkDictionary[Int(hours)]!
                    }
                    print("promille \(promille)")
                    drinkDictionary[Int(hours)] = promille
                }
            }
        }
    }
    
    func updatePromille()
    {
        currentState = 0
        var numberOfMinutesOfLast3Days = 72 * 60
        while numberOfMinutesOfLast3Days >= 0
        {
            if let value = drinkDictionary[numberOfMinutesOfLast3Days]
            {
                currentState += value
            }
            if currentState <= promilleLoss
            {
                currentState = 0
            }
            else
            {
                currentState -= promilleLoss
            }
            numberOfMinutesOfLast3Days = numberOfMinutesOfLast3Days - 1
        }
        currentState = currentState.truncate(places: 3)
        if currentState < 10
        {
            promilleLabel.font = promilleLabel.font.withSize(38)
        }
        let timeLeft = calc.timeLeft(promilleNumber: currentState)
        promilleLabel.numberOfLines = 0
        promilleLabel.text = String(currentState) + "‰"
        sobrietyLabel.textColor = UIColor.black
        sobrietyLabel.font = sobrietyLabel.font.withSize(20)
        if currentState == 0.0
        {
            sobrietyLabel.text = "Вы трезвы"
        }
        else if currentState > 0.0 && currentState <= 0.35
        {
            sobrietyLabel.text = "Концентрация алкоголя в крови в пределах допустимой нормы в 0.35‰. Можно садиться за руль. До полного выведения алкоголя из организма осталось \(timeLeft) часов"
        }
        else if currentState >= 5.0
        {
            sobrietyLabel.textColor = UIColor.red
            sobrietyLabel.text = "У вас опасный уровень алкоголя в крови. До полного выведения алкоголя из организма осталось \(timeLeft) часов"
        }
        else
        {
            sobrietyLabel.text = "До полного выведения алкоголя из организма осталось \(timeLeft) часов"
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
        addButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 1, right: 2)
    }
    // MARK: - Navigation

}
