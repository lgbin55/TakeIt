//
//  QNADataCell.swift
//  TakeIt
//
//  Created by 무릉 on 31/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class QNADataCell : UITableViewCell {
    
    @IBOutlet weak var qnaLabel: UILabel!
    @IBOutlet weak var writeDate: UILabel!
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
}
