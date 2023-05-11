//
//  SheetViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import UIKit

protocol sheetViewDelegate {
    func categoryOnClick(category: Category)
}

class SheetViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addNewCategoryButton: UIButton!
    
    lazy var viewModel: SheetViewModel = {
        return SheetViewModel()
    }()
    
    var delegate: sheetViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
        let cellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "CategoryCellView")
    }
    
    @IBAction func addNewOnClickHanlder(_ sender: Any) {
        let vc = AddNewCategoryViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    func prepareforCategory() {
        addNewCategoryButton.isHidden = true
    }
}

extension SheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel.categories.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = viewModel.categories[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellView", for: indexPath) as? CategoryCollectionViewCell {
            cell.categoryLabel.text = category.name
            cell.categoryImg.image = UIImage(named: category.name)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 3
        let cellWidth = (UIScreen.main.bounds.size.width) / numberOfCell - 24
        return CGSizeMake(cellWidth, cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.categoryOnClick(category: (viewModel.categories[indexPath.row]))
        self.dismiss(animated: true)
    }
}
extension SheetViewController: AddNewCategoryDelegate {
    func newCategory() {
        viewModel.refreshData()
        collectionView.reloadData()
    }
}



