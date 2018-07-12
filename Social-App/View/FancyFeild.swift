//
//  FancyFeild.swift
//  Social-App
//
//  Created by Asher Ahsan on 12/07/2018.
//  Copyright © 2018 swift. All rights reserved.
//

import UIKit

class FancyFeild : UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(red: CGFloat(SHADOW_GRAY), green: CGFloat(SHADOW_GRAY), blue: CGFloat(SHADOW_GRAY), alpha: 0.2).cgColor
        
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    
}
