//
//  BDGDataCell.swift
//  TakeIt
//
//  Created by 무릉 on 19/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//


import Foundation
import UIKit

class BoardDataSearchCell : UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    func initVars() {
        self.clipsToBounds = true
        thumbnail.layer.cornerRadius = 10.0
        thumbnail.layer.masksToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
}
