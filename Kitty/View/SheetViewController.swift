//
//  SheetViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import UIKit

class SheetViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomeViewModel?
    
    init() {
        super.init(nibName: "SheetViewController", bundle: Bundle(for: SheetViewController.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
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
    @IBAction func dismissClickHandler(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension SheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //    func set(value: [Item]){
    //        self.items = value
    //        self.collectionView.reloadData()
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = viewModel?.getAllCategory()[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellView", for: indexPath) as? CategoryCollectionViewCell {
            cell.categoryLabel.text = "Grocery. Grocery Grocery"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 3
        let cellWidth = (UIScreen.main.bounds.size.width) / numberOfCell - 24
        print(cellWidth)
        return CGSizeMake(cellWidth, cellWidth)
        
    }
    
}
    
    
    
