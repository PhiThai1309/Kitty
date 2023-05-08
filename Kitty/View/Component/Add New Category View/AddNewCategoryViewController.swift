//
//  AddNewCategoryViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/24/23.
//

import UIKit

protocol AddNewCategoryDelegate {
    func newCategory(newCategory: Category)
}

class AddNewCategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var iconImg: UIButton!
    
    var categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewModel: AddNewCategoryViewModel = {
        return AddNewCategoryViewModel()
    }()
    
    var delegate: AddNewCategoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func dismissOnClickHandler(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addNewCategoryOnClickHandler(_ sender: Any) {
        let newCategory = Category(name: categoryLabel.text!)
        delegate?.newCategory(newCategory: newCategory)
        self.dismiss(animated: true)
    }
    
    @IBAction func addIconOnClickHandler(_ sender: Any) {
        let categorySheetViewController = CategorySheetViewController(categories: categories)
        categorySheetViewController.delegate = self
        let nav = UINavigationController(rootViewController: categorySheetViewController)
        // 1
        nav.modalPresentationStyle = .pageSheet
        
        // 2
        if let sheet = nav.sheetPresentationController {
            // 3
            sheet.detents = [.medium(), .large()]
        }
        // 4
        present(nav, animated: true, completion: nil)
    }
}

extension AddNewCategoryViewController: CategorySheetDelegate
{
    func chooseIcon(category: String) {
        categoryLabel.text = category
        iconImg.setImage(UIImage(named: category), for: .normal)
    }
}

