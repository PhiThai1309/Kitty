//
//  ViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/14/23.
//

import UIKit
import MaterialComponents.MaterialAppBar

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpOnClickHandler(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)

        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil

        
    }
    
}

