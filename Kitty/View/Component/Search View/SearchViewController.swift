//
//  SearchViewController.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let dtFormatter = DateFormatter()
    
    lazy var viewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dtFormatter.dateStyle = .short
        dtFormatter.timeStyle = .none
        
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "CategorySearchCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "searchCell")
        
        let cellNib2 = UINib(nibName: "CardTableViewCell", bundle: nil)
        self.tableView.register(cellNib2, forCellReuseIdentifier: "CardViewCell")
        
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
            cell.labelText = item
            cell.categoryLabel.text = item
            cell.categoryImg.image = UIImage(named: String(item + "_Icon"))
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.categories[indexPath.row]
//        print(item)
    }
}

extension SearchViewController: SearchDelegate {
    func selected(category: String, check: Bool) {
        if check {
            if viewModel.search(data: category) {
//                print(viewModel.filterArray)
                tableView.reloadData()
            }
        } else {
            if viewModel.remove(data: category) {
                tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = viewModel.filterArray[indexPath.row]
//        print(history)
        // Fetch a cell of the appropriate type.
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardTableViewCell
        
        // Configure the cell’s contents.
        print(dtFormatter.string(from: history.date))
        cell.cardLabel.text = dtFormatter.string(from: history.date)
        cell.set(value: [history])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let array = viewModel.filterArray
//        if CGFloat(array.reversed()[indexPath.row].items.count * 56) > 0 {
//            return CGFloat(array.reversed()[indexPath.row].items.count * 50 + 70 + 10*array.reversed()[indexPath.row].items.count)
//        }
        return 120
    }
}


