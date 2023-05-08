//
//  AddNewViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import UIKit

protocol AddNewDelegate {
    func addNewItem()
}

class AddNewViewController: UIViewController {
    
    @IBOutlet weak var expenseTypeDropDown: UIButton!
    
    @IBOutlet weak var categorySheet: UIButton!
    @IBOutlet weak var descInput: UITextField!
    @IBOutlet weak var amountInput: UITextField!
    
    var items: [Item]
    var history: [History]
    var iconArray: [String]

    var delegate: AddNewDelegate?
    
    var option: String = "Expenses"
    var choosenCategory: Category = Category(name: "")
    
    init(items: [Item], history : [History], iconArray: [String]) {
        self.items = items
        self.history = history
        self.iconArray = iconArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewModel: AddNewViewModel = {
        return AddNewViewModel(items: items, history: history, iconArray: iconArray)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setCategoryButton()
        
    }
    
    @IBAction func backButtonOnClickHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func categoryClickHandler(_ sender: Any) {
//        print(categories)
        let detailViewController = SheetViewController()
        detailViewController.delegate = self
        let nav = UINavigationController(rootViewController: detailViewController)
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
    
    func setCategoryButton() {
        let optionClosure = {(action : UIAction) in
            self.option = action.title
        }
        expenseTypeDropDown.menu = UIMenu(title: "Choose your category", children :[
            UIAction(title: "Expenses", state: .on, handler: optionClosure),
            UIAction(title: "Income", state: .off, handler: optionClosure)
            ])
        
        
        expenseTypeDropDown.showsMenuAsPrimaryAction = true
        expenseTypeDropDown.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func addIncomeOnClickHandler(_ sender: Any) {
        if let inputAmount = amountInput.text , !inputAmount.isEmpty, !choosenCategory.name.isEmpty{
            let newItem = Item(category: (viewModel.findCategory(name: choosenCategory.name)), amount: Double(inputAmount)!, description: descInput.text!, categoryType: Option(rawValue: option)!)
            if (viewModel.addHistory(newItem: newItem, historyName: Date())) == true {
                delegate?.addNewItem()
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Please check your input",
                                          message: "The inputed amount have to be in Integer format and have selected a category",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                return
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension AddNewViewController: sheetViewDelegate {
    func categoryOnClick(category: Category) {
        choosenCategory = category
        categorySheet.setTitle(category.name, for: .normal)
        categorySheet.setTitleColor(.label, for: .normal)
    }
}
