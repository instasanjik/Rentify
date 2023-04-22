//
//  SKTextField.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class SKTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 56))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        // Set the font and text color
        font = UIFont.systemFont(ofSize: 17)
        textColor = .black
        
        // Set the border style, background color, and corner radius
        borderStyle = .roundedRect
        backgroundColor = .white
        layer.cornerRadius = 5
        
        // Set the left view to a blank view with a fixed width to create padding
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 1))
        leftViewMode = .always
        
        // Set the clear button mode to appear while editing
        clearButtonMode = .whileEditing
        
        // Set the return key type to "done"
        returnKeyType = .done
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 8)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 8)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 8)
    }
    
}
