//
//  LoginViewController.swift
//  Kitty
//
//  Created by phi.thai on 5/12/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .systemBackground
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    @IBAction func signUpOnClickHandler(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
                
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            self.navigationController?.pushViewController(vc, animated: true)

            self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
          }
    }

}
