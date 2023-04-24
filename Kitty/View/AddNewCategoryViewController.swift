//
//  AddNewCategoryViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/24/23.
//

import UIKit

class AddNewCategoryViewController: UIViewController {
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func dismissOnClickHandler(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addIconOnClickHandler(_ sender: Any) {
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
}
