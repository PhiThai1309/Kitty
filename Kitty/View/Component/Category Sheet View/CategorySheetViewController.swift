//
//  CategorySheetViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/24/23.
//

import UIKit

protocol CategorySheetDelegate {
    func chooseIcon(category: String)
}

class CategorySheetViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var iconArray: [String] = {
        return Icon().iconArray
    }()
    
    var categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var remainIconArray: [String] = []
    
    var delegate: CategorySheetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterIcon()

        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "CategoryCellView")
    }
    
    func filterIcon() {
        remainIconArray = iconArray.filter { icon in
            return !categories.contains { category in
                return category.name == icon
            }
        }
    }
}

extension CategorySheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (remainIconArray.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let icon = remainIconArray[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellView", for: indexPath) as? CategoryCollectionViewCell {
            cell.categoryLabel.text = ""
            cell.categoryImg.image = UIImage(named: icon)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 4
        let cellWidth = (UIScreen.main.bounds.size.width) / numberOfCell - 24
        return CGSizeMake(cellWidth, cellWidth - 5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        delegate?.chooseIcon(category: (remainIconArray[indexPath.row]))
        self.dismiss(animated: true)
    }
    
}

