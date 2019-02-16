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
        //let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        //let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 50)
        //let circle = UIBezierPath(ovalIn: rect)
        //let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
        //let img = renderer.image(actions: { ctx in
        //    ctx.cgContext.setFillColor(UIColor.red.cgColor)
        //    ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
        //    ctx.cgContext.setLineWidth(10)
        //    let rectangle = CGRect(x: 50, y: 50, width: 50, height: 50)
        //    ctx.cgContext.addEllipse(in: rectangle)
        //    ctx.cgContext.drawPath(using: .fillStroke)
        //})
        
        let circle = CircleView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        circle.center = CGPoint(x: view.center.x, y: view.frame.height/5)
        self.view.addSubview(circle)
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
