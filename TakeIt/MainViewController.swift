//
//  ViewController.swift
//  TakeIt
//
//  Created by 무릉 on 19/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItemSet()
    }

    @IBAction func sideMenuAction(_ sender: Any) {
    }
   
    func navigationItemSet(){
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "icon_alarm_on"), for: .normal)
        button.addTarget(self, action: #selector(fbButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    @objc func fbButtonPressed() {
        print("click")
    }
}

