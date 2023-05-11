//
//  MonthViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/25/23.
//

import UIKit

protocol MonthViewDelegate {
    func returnMonth(month: String)
}

class MonthViewController: UIViewController {
    
    lazy var viewModel = {
        return MainViewModel()
    }()
    
    var delegate: MonthViewDelegate?
    
    init() {
        super.init(nibName: "MonthViewController", bundle: Bundle(for: MonthViewController.self))
        self.modalPresentationStyle = .overCurrentContext  //To present over current view in full screen
        self.modalTransitionStyle = .crossDissolve //transition effect
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        
        let cellNib = UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "ButtonCell")
    }
    
    @IBAction func dismissOnClickHandler(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension MonthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.getAllMonth()[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? ButtonCollectionViewCell {
            cell.monthBtn.setTitle(item, for: .normal)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(80, 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.returnMonth(month: viewModel.getAllMonth()[indexPath.row])
        self.dismiss(animated: true)
    }
    
}

