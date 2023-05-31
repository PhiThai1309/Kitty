//
//  CategorySearchCollectionViewCell.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import UIKit

protocol SearchDelegate {
    func selected(category: String, check: Bool)
}

class CategorySearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var wrapperView: ChipsControl!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var labelText: String?
    var delegate: SearchDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        wrapperView.labelText = labelText ?? "Hello"
        wrapperView.delegate = self
    }
    
    func set(text: String) {
        labelText = text
    }
}

extension CategorySearchCollectionViewCell: ChipsControlDelegate {
    func selected(state: Bool) {
        delegate?.selected(category: categoryLabel.text!, check: state)
    }
}
