//
//  RoundedCornerView.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/19/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//THIS ONE WORKS!!!!!!!!!!!!!!!!!!!! DOESNT CRASH SIMULATOR

import UIKit

@IBDesignable
class RoundedCornerView: UIView {
    
    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}
