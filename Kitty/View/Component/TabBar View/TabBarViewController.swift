//
//  TabBarViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/21/23.
//

import UIKit 

class TabBarViewController: UITabBarController {

    lazy var viewModel: MainViewModel = {
        return MainViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.selectedIndex = 1
    }
}
