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
    
    var viewModel: HomeViewModel?
    var delegate: sheetViewDelegate?
    
    init() {
        super.init(nibName: "SheetViewController", bundle: Bundle(for: SheetViewController.self))
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
    
    
    @IBAction func addNewOnClickHanlder(_ sender: Any) {
        let vc = AddNewCategoryViewController()
        vc.viewModel = viewModel
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(nav, animated: true)
        self.present(nav, animated: true)
    }
    
    func prepareforCategory() {
        addNewCategoryButton.isHidden = true
    }
}

extension SheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel!.getAllCategory().count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = viewModel?.getAllCategory()[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellView", for: indexPath) as? CategoryCollectionViewCell {
            cell.categoryLabel.text = category?.name
            cell.categoryImg.image = UIImage(named: category!.name)
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
        
        delegate?.categoryOnClick(category: (viewModel?.getAllCategory()[indexPath.row])!)
        self.dismiss(animated: true)
    }
    
}



