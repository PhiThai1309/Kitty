//
//  ChipsControl.swift
//  Kitty
//
//  Created by phi.thai on 5/30/23.
//

import UIKit

protocol ChipsControlDelegate {
    func selected(state: Bool)
}

@IBDesignable
class ChipsControl: UIControl {
    
    @IBInspectable private weak var container: UIView!
    @IBInspectable private weak var textLabel: UILabel!
    @IBInspectable private weak var imageView: UIImageView!
    
    var categories: [String] = ["Grocery", "Cafe", "Health", "Commute", "Shopping"]
//    var labelText: String
    
    var delegate: ChipsControlDelegate?
    
    @IBInspectable
    public var check: Bool = false {
        didSet{
//            imageView.image = image
            container.borderColor = borderColors
            container.borderWidth = 1
            container.cornerRadius = 6
            container.backgroundColor = backgroundColors
            
            delegate?.selected(state: check)
        }
    }
    
//    private var image: UIImage {
//        return check ?  UIImage(systemName: "checkmark.square.fill")! : UIImage()
//    }
    
    private var borderColors: UIColor {
        return check ? UIColor(red: 0, green: 0.416, blue: 0.867, alpha: 1) : UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
    }
    
    private var backgroundColors: UIColor {
        return check ? UIColor(red: 0.859, green: 0.933, blue: 0.988, alpha: 0.3) : UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.clear
        container.borderColor = borderColors
        container.borderWidth = 1
        container.cornerRadius = 6
        addSubview(container)
        
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        container.addSubview(imageView)
        
//        let textLable = UILabel()
//        textLable.text = labelText
//        textLable.translatesAutoresizingMaskIntoConstraints = false
//        textLable.font(UIFont(name: "System", size: 14))
//        container.addSubview(textLable)
        
//        imageView.image = image
//        imageView.contentMode = .scaleAspectFit
        
        container.heightAnchor.constraint(equalToConstant: 32).isActive = true
//        container.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        container.topAnchor.constraint(equalTo: container.superview!.topAnchor, constant: 0 ).isActive = true
//        container.bottomAnchor.constraint(equalTo: container.superview!.bottomAnchor, constant: 0 ).isActive = true
        container.leftAnchor.constraint(equalTo: leftAnchor, constant: 0 ).isActive = true
        container.rightAnchor.constraint(equalTo: rightAnchor, constant: 0 ).isActive = true
        
//        imageView.centerYAnchor.constraint(equalTo: imageView.superview!.centerYAnchor).isActive = true
//        imageView.leftAnchor.constraint(equalTo: imageView.superview!.leftAnchor, constant: 11 ).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
        
//        textLable.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
//        textLable.rightAnchor.constraint(equalTo: textLable.superview!.rightAnchor, constant: -11).isActive = true
//        textLable.centerYAnchor.constraint(equalTo: textLable.superview!.centerYAnchor).isActive = true

//        self.imageView = imageView
        self.container = container
//        self.textLabel = textLable
        backgroundColor = UIColor.clear
//        imageView.addTarget(self, action: #selector(touchHandler))
        
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchHandler))
        container.addGestureRecognizer(tap)
        container.isUserInteractionEnabled = true
        
    }
    
    @objc func touchHandler() {
        check = !check
        
        sendActions(for: .valueChanged)
    }
}
