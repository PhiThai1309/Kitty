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
    
    
    @IBOutlet weak var textField: UITextField!
    
    let dtFormatter = DateFormatter()
    
    lazy var viewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dtFormatter.dateStyle = .short
        dtFormatter.timeStyle = .none
        
        viewModel.delegate = self
        viewModel.loadData()
        
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "CategorySearchCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "searchCell")
        
        let cellNib2 = UINib(nibName: "CardTableViewCell", bundle: nil)
        self.tableView.register(cellNib2, forCellReuseIdentifier: "CardViewCell")
        
    }
    
    @IBAction func backOnClickHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchQuery(_ sender: Any) {
        if(textField.text! != "") {
            viewModel.searchAdvance(query: textField.text!, data: "")
        } else {
            viewModel.clearData()
        }
        tableView.reloadData()
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
}

extension SearchViewController: SearchDelegate {
    func selected(category: String, check: Bool) {
        if check {
            viewModel.searchAdvance(query: textField.text ?? "", data: category)
        } else {
            viewModel.remove(data: category, query: textField.text ?? "")
        }
        tableView.reloadData()
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
        cell.cardLabel.text = dtFormatter.string(from: history.date)
        cell.set(value: [history])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension SearchViewController: SearchViewModelDelegate {
    func loadData() {
        collectionView.reloadData()
        tableView.reloadData()
    }
}


