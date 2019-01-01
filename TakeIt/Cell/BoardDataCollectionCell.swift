//
//  BDGDataCollectionCell.swift
//  TakeIt
//
//  Created by 무릉 on 19/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class BoardDataCollectionCell : UICollectionViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    
    func initVars() {
        self.clipsToBounds = true
        thumbnail.layer.cornerRadius = 5.0
        thumbnail.layer.masksToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
}
