//
//  SelectedButton.swift
//  Kitty
//
//  Created by phi.thai on 5/31/23.
//

import UIKit

@IBDesignable class SelectedButton: UIButton {

    // Allows developer to edit what colors are shown in each state
    @IBInspectable var borderColorSelected:UIColor = UIColor.purple
    @IBInspectable var borderColorDeselected:UIColor = UIColor.purple
    
    @IBInspectable var bordersWidth:CGFloat = 3
    @IBInspectable var cornersRadius:CGFloat = 10
    
    // The text that's shown in each state
    @IBInspectable var selectedText:String = "Selected"
    @IBInspectable var deselectedText:String = "Deselected"
    
    // The color of text shown in each state
    @IBInspectable var textColorDeselected:UIColor = UIColor.lightGray
    @IBInspectable var textColorSelected:UIColor = UIColor.black
    
    // Sets the Active/Inactive State
    @IBInspectable var active:Bool = false
    
    // Custom Border to the UIButton
    private let border = CAShapeLayer()
    
    var name: String?

    override func draw(_ rect: CGRect) {
        
        // Setup CAShape Layer (Dashed/Solid Border)
        border.lineWidth = bordersWidth
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornersRadius).cgPath
        self.layer.addSublayer(border)
        
        self.layer.cornerRadius = cornersRadius
        self.layer.masksToBounds = true
        
        // Setup the Button Depending on What State it is in
        if active {
            setSelected()
        } else {
            setDeselected()
        }
        
        // Respond to touch events by user
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    @objc func onPress() {
        print(name)
        active = !active
        
        if active {
            setSelected()
        } else {
            setDeselected()
        }
    }
    
    // Set the selected properties
    func setSelected() {
        border.lineDashPattern = nil
        border.strokeColor = borderColorSelected.cgColor
        self.setTitle(selectedText, for: .normal)
        self.setTitleColor(textColorSelected, for: .normal)
    }
    
    // Set the deselcted properties
    func setDeselected() {
        border.lineDashPattern = [4, 4]
        border.strokeColor = borderColorDeselected.cgColor
        self.setTitle(deselectedText, for: .normal)
        self.setTitleColor(textColorDeselected, for: .normal)
    }

}

