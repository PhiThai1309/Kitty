//
//  SearchViewController.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var viewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "CategorySearchCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "searchCell")
        
    }
    
    @IBAction func backOnClickHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.categories[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? CategorySearchCollectionViewCell {
            cell.categoryLabel.text = item
            cell.categoryImg.image = UIImage(named: item)
            return cell
        }
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let _: CGFloat = 1
//        let cellWidth = UIScreen.main.bounds.size.width
//        return CGSizeMake(cellWidth - 16*2, 50)
//    }
    
}


