//
//  AddNewCategoryViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/24/23.
//

import UIKit

class AddNewCategoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func dismissOnClickHandler(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
