//
//  ARoundView.swift
//  TakeIt
//
//  Created by 무릉 on 20/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ARoundView : UIView {
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor : UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
