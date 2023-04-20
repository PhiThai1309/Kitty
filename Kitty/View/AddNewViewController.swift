//
//  AddNewViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import UIKit

class AddNewViewController: UIViewController {

    @IBOutlet weak var expenseTypeDropDown: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCategoryButton()
    }

    @IBAction func backButtonOnClickHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func categoryClickHandler(_ sender: Any) {
        let newViewController = SheetViewController()
        self.present(newViewController, animated: true)
    }
    
    func setCategoryButton() {
        let optionClosure = {(action : UIAction) in
//            self.category = action.title
            print(action.title)
        }
        expenseTypeDropDown.menu = UIMenu(title: "Choose your category", children :[
            UIAction(title: "Income", state: .on, handler: optionClosure),
            UIAction(title: "Expense", state: .off, handler: optionClosure)])
        
        
        expenseTypeDropDown.showsMenuAsPrimaryAction = true
        expenseTypeDropDown.changesSelectionAsPrimaryAction = true
    }
}
