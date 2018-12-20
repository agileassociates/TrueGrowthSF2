//
//  CurrencyTextField.swift
//  WindowShopper
//
//  Created by Johny Babylon on 12/18/18.
//  Copyright © 2018 Johny Babylon. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTextField: UITextField {
    
    override func draw(_ rect: CGRect) {
        let size: CGFloat = 20
        let currencyLabel = UILabel(frame: CGRect(x: 5, y: (frame.size.height / 2) - size / 2, width: size, height: size))
        currencyLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        currencyLabel.layer.cornerRadius = 5.0
        currencyLabel.clipsToBounds = true
 
        
        /*let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        currencyLabel.text = formatter.currencySymbol
        addSubview(currencyLabel)*/
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5119388204)
        layer.cornerRadius = 5.0
        textAlignment = .center
        clipsToBounds = true
        
        if placeholder == nil {
            placeholder = " "
        }
        
        let place = NSAttributedString(string: placeholder!, attributes:[.foregroundColor: UIColor.white])
        attributedPlaceholder = place
        textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }

}
