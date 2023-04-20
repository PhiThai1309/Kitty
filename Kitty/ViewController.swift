//
//  ViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/14/23.
//

import UIKit

class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .systemBackground
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    @IBAction func signUpOnClickHandler(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        self.navigationController?.pushViewController(vc, animated: true)

        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil

        
    }
    
}

