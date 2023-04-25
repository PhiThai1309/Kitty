//
//  TabBarViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/21/23.
//

import UIKit 

class TabBarViewController: UITabBarController {

    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.selectedIndex = 1
        
        let firstVC = self.viewControllers![0] as! ReportViewController //first view controller in the tabbar
        firstVC.viewModel = viewModel
        
        let secondVC = self.viewControllers![1] as! HomeViewController //first view controller in the tabbar
        secondVC.viewModel = viewModel
        
        _ = self.viewControllers![2] as! SettingsViewController //first view controller in the tabbar

        
        
    }
}
