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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    lazy var viewModel: SettingsViewModel = {
        return SettingsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL!
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: photoURL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                    self.imageView.cornerRadius = 20
                }
            }
            
            nameLabel.text = uid
            emailLabel.text = email
        }
        
        viewModel.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.loadData()
    }
    
    @IBAction func exportOnClickHandler(_ sender: Any) {
        let pdfData = viewModel.generatePdfData(items: viewModel.items)
        let newViewController = PDFViewController()
        newViewController.documentData = pdfData
        self.present(newViewController, animated: true)
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
