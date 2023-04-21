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
    @IBOutlet weak var totalLabel: UILabel!
    
    var items: [Item]?
    var sum: Double = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardCollectionView.dataSource = self
        self.cardCollectionView.delegate = self
        
        let cellNib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        self.cardCollectionView.register(cellNib, forCellWithReuseIdentifier: "ItemCellView")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension CardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func set(value: [Item]){
        self.items = value
        self.cardCollectionView.reloadData()
        for item in items! {
            sum += item.amount
        }
        
        totalLabel.text = String(sum)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items![indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellView", for: indexPath) as? ItemCollectionViewCell {
            cell.typeLabel.text = item.category.name
            cell.descLabel.text = item.category.name
            cell.amountLabel.text = String(item.amount)
            cell.iconImg.image = UIImage(named: item.category.name)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _: CGFloat = 1
        let cellWidth = UIScreen.main.bounds.size.width
        return CGSizeMake(cellWidth - 16*2, 50)
    }
    
}

