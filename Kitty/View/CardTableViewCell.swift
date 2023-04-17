//
//  CardTableViewCell.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import UIKit

@IBDesignable
class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var cardLabel: UILabel!
    
    var items: [Item]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
