//
//  AddNewViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import UIKit

class AddNewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonOnClickHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func categoryClickHandler(_ sender: Any) {
        let newViewController = SheetViewController()
        self.present(newViewController, animated: true)
    }
}
