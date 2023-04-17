//
//  HomeViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/14/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel:HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "CardTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "CardViewCell")
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllHistory().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = viewModel.getAllHistory()[indexPath.row]
        // Fetch a cell of the appropriate type.
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardTableViewCell
        
        //         Configure the cell’s contents.
        cell.cardLabel.text = history.date
//        cell.items = history.items
        
        cell.set(value: history.items)
        
        //        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if CGFloat(viewModel.getAllHistory()[indexPath.row].items.count * 56) > 0 {
            return CGFloat(viewModel.getAllHistory()[indexPath.row].items.count * 56 + 36)
        }
        return 70
    }
}
