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
    var viewModel: HomeViewModel?
    
    var delegate: CategorySheetDelegate?
    
    init() {
        super.init(nibName: "CategorySheetViewController", bundle: Bundle(for: CategorySheetViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "CategoryCellView")
    }
}

extension CategorySheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel!.getAllIcon().count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let icon = viewModel?.getAllIcon()[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellView", for: indexPath) as? CategoryCollectionViewCell {
            cell.categoryLabel.text = ""
            cell.categoryImg.image = UIImage(named: icon!)
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

        delegate?.chooseIcon(category: (viewModel?.getAllIcon()[indexPath.row])!)
        self.dismiss(animated: true)
    }
    
}

