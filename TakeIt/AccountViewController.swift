//
//  AccountViewController.swift
//  TakeIt
//
//  Created by 무릉 on 21/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController : BaseViewController {
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        profileImage.layer.cornerRadius = profileImage.frame.width / 2.5
        profileImage.layer.masksToBounds = true
    }
    
}
