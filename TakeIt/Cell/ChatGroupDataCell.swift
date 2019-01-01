//
//  ChatRoomDataCell.swift
//  TakeIt
//
//  Created by 무릉 on 29/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class ChatGroupDataCell : UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func initVars() {
        self.clipsToBounds = true
        thumbnail.layer.cornerRadius = thumbnail.frame.height / 2
        thumbnail.layer.masksToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
}
