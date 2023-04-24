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
    
    @IBOutlet weak var descInput: UITextField!
    @IBOutlet weak var amountInput: UITextField!
    
    var viewModel: HomeViewModel?
    
    var delegate: AddNewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setCategoryButton()
        
    }
    
    @IBAction func backButtonOnClickHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func categoryClickHandler(_ sender: Any) {
        let detailViewController = SheetViewController()
        detailViewController.viewModel = viewModel
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
            print(action.title)
        }
        expenseTypeDropDown.menu = UIMenu(title: "Choose your category", children :[
            UIAction(title: "Income", state: .on, handler: optionClosure),
            UIAction(title: "Expense", state: .off, handler: optionClosure)])
        
        
        expenseTypeDropDown.showsMenuAsPrimaryAction = true
        expenseTypeDropDown.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func addIncomeOnClickHandler(_ sender: Any) {
        let newItem = Item(category: (viewModel?.findCategory(name: "Grocery"))!, amount: Double(amountInput.text!)!, description: descInput.text!, categoryType: type.Expenses)
        if (viewModel?.addHistory(newItem: newItem, historyName: "today")) == true {
            delegate?.addNewItem()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
