//
//  ReportDetailsView.swift
//  Kitty
//
//  Created by phi.thai on 6/12/23.
//

import Foundation
import UIKit

class ReportDetailsView: UIViewController {
    var items: [Item]?
    let dtFormatter = DateFormatter()
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        dtFormatter.dateStyle = .short
        dtFormatter.timeStyle = .none
        
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "CardTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "CardViewCell")
        
        titleButton.setTitle(items![0].category, for: .normal)
    }
    
    @IBAction func returnOnClickHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReportDetailsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items![indexPath.row]
        // Fetch a cell of the appropriate type.
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardTableViewCell
        
        // Configure the cell’s contents.
        cell.cardLabel.text = dtFormatter.string(from: item.date)
        cell.set(value: [item])
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
