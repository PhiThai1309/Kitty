//
//  ManageCategoriesViewController.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import UIKit

class ManageCategoriesViewController: UIViewController {
    
    @IBOutlet weak var returnBtn: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel : ManageCategoriesViewModel = {
        return ManageCategoriesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        tableView.dragInteractionEnabled = true
//            tableView.dragDelegate = self
        tableView.isEditing = true

            navigationItem.rightBarButtonItem = editButtonItem
        
    }
    
    @IBAction func returnOnClickHandler(_ sender: Any) {
        viewModel.saveChanges()
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func addNewOnClickHandler(_ sender: Any) {
        let vc = AddNewCategoryViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
}

extension ManageCategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = viewModel.categories[indexPath.row]
        // Fetch a cell of the appropriate type.
        let cell =  tableView.dequeueReusableCell(withIdentifier: "categoriesViewCell", for: indexPath) as! ManageCategoriesTableViewCell

        // Configure the cell’s contents.
        cell.categoryImage.image = UIImage(named: category)
        cell.categoryLabel.text = category
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        viewModel.moveCategory(move: sourceIndexPath.row, path: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}

extension ManageCategoriesViewController: AddNewCategoryDelegate {
    func newCategory() {
        viewModel.refreshData()
        tableView.reloadData()
    }
    
    
}



