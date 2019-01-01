//
//  BoardMainBannerCell.swift
//  TakeIt
//
//  Created by 무릉 on 26/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class BoardMainBannerCell : UICollectionReusableView {
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerButton: UIButton!
    
    func initVars() {
        self.clipsToBounds = true
        bannerImage.layer.cornerRadius = 5.0
        bannerImage.layer.masksToBounds = true
        bannerButton.layer.cornerRadius = 5.0
        bannerButton.layer.masksToBounds = true
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
}
