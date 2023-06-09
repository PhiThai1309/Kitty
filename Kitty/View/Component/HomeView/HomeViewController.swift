//
//  HomeViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/14/23.
//

import UIKit

class HomeViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var addNewBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    
    @IBOutlet weak var monthBtn: UIButton!
    
    let dtFormatter = DateFormatter()
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dtFormatter.dateStyle = .short
        dtFormatter.timeStyle = .none
        
        viewModel.delegate = self
        viewModel.loadData()
        
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "CardTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "CardViewCell")
    }
    
    
    @IBAction func addNewButtonClickHandler(_ sender: Any) {
        let newViewController = AddNewViewController()

        newViewController.delegate = self
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.loadData()
    }
    
    @IBAction func settingOnClickButton(_ sender: Any) {
        tabBarController!.selectedIndex = 2
    }
    
    @IBAction func showCalendar(_ sender: Any) {
        let datePicker = MonthViewController()
        datePicker.delegate = self
        self.present(datePicker, animated: true)
    }
    
    @IBAction func rightDateOnClickHandler(_ sender: Any) {
        let year = viewModel.addAMonth()
        monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(year), for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func leftDateOnClickhandler(_ sender: Any) {
        let year = viewModel.backAMonth()
        monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(year), for: .normal)
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFilteredHistoryDate(date: viewModel.filteredMonth).reversed().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = viewModel.getFilteredHistoryDate(date: viewModel.filteredMonth).reversed()[indexPath.row]
        // Fetch a cell of the appropriate type.
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardTableViewCell
        
        // Configure the cell’s contents.
        cell.cardLabel.text = dtFormatter.string(from: history.date)
        cell.set(value: Array(history.items))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let array = viewModel.getFilteredHistoryDate(date: viewModel.filteredMonth)
        if CGFloat(array.reversed()[indexPath.row].items.count * 56) > 0 {
            return CGFloat(array.reversed()[indexPath.row].items.count * 50 + 70 + 10*array.reversed()[indexPath.row].items.count)
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.2*Double(indexPath.row),animations: { () -> Void in
        cell.alpha = 1

            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
}

extension HomeViewController: AddNewDelegate {
    func addNewItem(newItem: Item) {
        viewModel.setCurrentMonth()
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: viewModel.filteredMonth)
        monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(calendarDate.year!), for: .normal)
    }
}

extension HomeViewController: MonthViewDelegate {
    func returnMonth(month: String) {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "LLLL"  // if you need 3 letter month just use "LLL"
        if let date = df.date(from: month) {
            let monthInt = Calendar.current.component(.month, from: date)
            let components = DateComponents (calendar: Calendar.current, year: 2023, month: monthInt, day: 14)
            let date = NSCalendar.current.date(from: components)
            viewModel.setMonth(month: date!)
            monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(components.year!), for: .normal)
        }
        tableView.reloadData()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func loadData() {
        self.tableView.reloadData()
        
        self.viewModel.history = self.viewModel.database.loadHistoryWithMonth(items: self.viewModel.items)
        self.monthBtn.setTitle(self.viewModel.convertToNormalDate(), for: .normal)
        self.expenseLabel.text = "- " + String(self.viewModel.getExpense())
        self.incomeLabel.text = String(self.viewModel.getIncome())
        self.balanceLabel.text = String(self.viewModel.getBalance())
    }
}
