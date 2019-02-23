//
//  StateVC.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 06.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

let calc = PromilleCalculator()
var currentState: Double = 0
var drinkDictionary: [Int : Double] = [:]
let promilleLoss = 0.15 / 60
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
        promilleLabel.font = promilleLabel.font.withSize(32)
        promilleLabel.textColor = UIColor.black
        self.view.addSubview(circle)
        self.view.addSubview(promilleLabel)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        calc.fillLast3DaysDrinkArray()
        print(last3DaysDrinkArray, last3DaysDrinkArray.count)
        fillDrinkDictionary()
        //print("\n\n\n\n\ndrinkDictionary \(drinkDictionary)\n\n\n\n\n")
        if drinkNameArray.count == 0
        {
            sobrietyLabel.text = "Для более точного расчета количества алкоголя в крови требуется ввести свои данные в настройках"
            promilleLabel.text = "0.0‰"
        }
        else
        {
            updatePromille()
        }
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateInfoWithTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        timer.invalidate()
    }
    
    @objc func updateInfoWithTimer()
    {
        fillDrinkDictionary()
        updatePromille()
        //print("timer fires")
    }
    
    func fillDrinkDictionary()
    {
        drinkDictionary = [:]
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
                //print("promille \(promille)")
                drinkDictionary[Int(hours)] = promille
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
                //print("currentState = \(currentState)")
            }
            numberOfMinutesOfLast3Days = numberOfMinutesOfLast3Days - 1
        }
        currentState = Double(round(1000 * currentState) / 1000) //округление до 2 знака после запятой
        let timeLeft = calc.timeLeft(promilleNumber: currentState)
        promilleLabel.text = String(currentState) + "‰"
        if currentState == 0.0
        {
            sobrietyLabel.text = "Вы трезвы"
        }
        else if currentState >= 0.1 && currentState <= 0.35
        {
            
            sobrietyLabel.text = "Концентрация алкоголя в крови в пределах допустимой нормы в 0.35‰. Можно садиться за руль. До полного выведения алкоголя из организма осталось \(timeLeft) часов"
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
    }
    // MARK: - Navigation

}
