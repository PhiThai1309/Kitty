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
        
        
        let firstVC = self.viewControllers![0] as! ReportViewController //first view controller in the tabbar
//        firstVC.set(items: viewModel.getAllItems(), history: viewModel.getAllHistory(), filteredMonth: viewModel.getCurrentMonth())

        let secondVC = self.viewControllers![1] as! HomeViewController //first view controller in the tabbar
//        secondVC.set(items: viewModel.getAllItems(), history: viewModel.getAllHistory(), income: viewModel.getIncome(), iconArray: viewModel.getAllIcon(), month: viewModel.getAllMonth(), filteredMonth: viewModel.getCurrentMonth())
//        
        _ = self.viewControllers![2] as! SettingsViewController //first view controller in the tabbar

        
        
    }
}
