//
//  AddNewViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import UIKit

protocol AddNewDelegate {
    func addNewItem(newItem: Item)
}

class AddNewViewController: UIViewController {
    
    @IBOutlet weak var expenseTypeDropDown: UIButton!
    
    @IBOutlet weak var categorySheet: UIButton!
    @IBOutlet weak var descInput: UITextField!
    @IBOutlet weak var amountInput: UITextField!
    
    var iconArray: [String] = []

    var delegate: AddNewDelegate?
    
    var option: String = "Expenses"
    var choosenCategory: String = ""
    
    lazy var viewModel: AddNewViewModel = {
        return AddNewViewModel(iconArray: iconArray)
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
        if let inputAmount = amountInput.text , !inputAmount.isEmpty, !choosenCategory.isEmpty{
            let newItem = Item(category: (viewModel.findCategory(name: choosenCategory)), amount: Double(inputAmount)!, description: descInput.text!, categoryType: Option(rawValue: option)!)
            delegate?.addNewItem(newItem: newItem)
            viewModel.addNew(item: newItem)
            self.navigationController?.popViewController(animated: true)
            
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
    func categoryOnClick(category: String) {
        choosenCategory = category
        categorySheet.setTitle(category, for: .normal)
        categorySheet.setTitleColor(.label, for: .normal)
    }
}
