//
//  HistoryItemCell.swift
//  TakeIt
//
//  Created by 무릉 on 30/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class HistoryItemCell : UITableViewCell {
    
    @IBOutlet weak var historyText: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
}
