//
//  SettingsViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/24/23.
//

import UIKit
import FirebaseAuth
import PDFKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            
            nameLabel.text = uid
            emailLabel.text = email
        }
        
    }
    
    @IBAction func logOutOnClickHandler(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        if Auth.auth().currentUser == nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
