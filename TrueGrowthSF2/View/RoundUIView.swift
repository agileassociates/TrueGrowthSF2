//
//  RoundUIView.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/19/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//THIS ONE CRASHES SIMULATOR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import Foundation
import UIKit

@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 25 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    
}
