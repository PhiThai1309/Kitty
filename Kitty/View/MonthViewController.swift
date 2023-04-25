//
//  MonthViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/25/23.
//

import UIKit

class MonthViewController: UIViewController {
    
    init() {
        super.init(nibName: "MonthViewController", bundle: Bundle(for: MonthViewController.self))
        self.modalPresentationStyle = .overCurrentContext //To present over current view in full screen
        self.modalTransitionStyle = .coverVertical //transition effect
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissOnClickHandler(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
