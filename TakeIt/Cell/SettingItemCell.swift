//
//  SettingItemCell.swift
//  TakeIt
//
//  Created by 무릉 on 29/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class SettingItemCell : UITableViewCell {
    
    
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
}
