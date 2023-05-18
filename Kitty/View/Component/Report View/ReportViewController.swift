
//
//  ReportViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import Foundation
import Charts
import OrderedCollections

class ReportViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    lazy var viewModel: ReportViewModel = {
        return ReportViewModel()
    }()
    var sum: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chartView.delegate = self
        var entries = [BarChartDataEntry]()
        let value = Array(viewModel.categoryWithAmount.values)
        entries.append (BarChartDataEntry (x: Double(0.1),
                                           yValues: value))
        let set = BarChartDataSet (entries: entries)
        set.colors = [UIColor.red,UIColor.orange,UIColor.green,UIColor.black,UIColor.blue]
        chartView.animate(yAxisDuration: 0.5)
        let data = BarChartData (dataSet: set)
        chartView.data = data
        chartTheme()
        
        let cellNib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        self.reportCollectionView.register(cellNib, forCellWithReuseIdentifier: "ItemCellView")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchData()
        
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: viewModel.filteredMonth)
        
        monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(calendarDate.year!), for: .normal)
        var entries = [BarChartDataEntry]()
        let value = Array(viewModel.categoryWithAmount.values)
        entries.append (BarChartDataEntry (x: Double(0.1),
                                           yValues: value))
        let set = BarChartDataSet (entries: entries)
        set.colors = [UIColor(red: 0.80, green:0.32, blue:0.32, alpha:1.0),
                      UIColor(red: 0, green: 0.4902, blue: 0.9176, alpha: 1.0),
                      UIColor(red: 0, green: 0.6784, blue: 0.5647, alpha: 1.0),
                      UIColor(red: 0.7686, green: 0.4471, blue: 0, alpha: 1.0),
                      UIColor(red: 0.6667, green: 0, blue: 0.2667, alpha: 1.0),
                      UIColor(red: 0, green: 0.8, blue: 0.6392, alpha: 1.0)]
        chartView.animate(yAxisDuration: 0.5)
        let data = BarChartData (dataSet: set)
        chartView.data = data
        chartView.animate(yAxisDuration: 0.5)
        reportCollectionView.reloadData()
        chartTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
    func chartTheme() {
        chartView.chartDescription.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.drawBordersEnabled = false
        chartView.legend.form = .none
        self.chartView.legend.enabled = false
        chartView.barData?.setValueTextColor(.clear)
    }
    
    @IBAction func showCalendar(_ sender: Any) {
        let datePicker = MonthViewController()
        datePicker.delegate = self
        self.present(datePicker, animated: true)
    }
    
    @IBAction func rightOnClickHandler(_ sender: Any) {
        let year = viewModel.addAMonth()
        monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(year), for: .normal)
        reportCollectionView.reloadData()
    }
    
    @IBAction func leftOnClickHandler(_ sender: Any) {
        let year = viewModel.backAMonth()
        monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(year), for: .normal)
        reportCollectionView.reloadData()
    }
}

extension ReportViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryReport.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let amount = viewModel.categoryReport[indexPath.row]

        // Fetch a cell of the appropriate type.
        if let cell = reportCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellView", for: indexPath) as? ItemCollectionViewCell {

             cell.typeLabel.text = amount[0].category
            cell.amountLabel.text = String(Array(viewModel.categoryWithAmount)[indexPath.row].value)
            cell.iconImg.image = UIImage(named: amount[0].category)
            let categories = viewModel.getArrayOfEachCategory()

            cell.descLabel.text = String(categories[indexPath.row].count) + " transactions"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _: CGFloat = 1
        let cellWidth = UIScreen.main.bounds.size.width
        return CGSizeMake(cellWidth, 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        cell.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.2*Double(indexPath.row),animations: { () -> Void in
        cell.alpha = 1

            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
}

extension ReportViewController: MonthViewDelegate {
    func returnMonth(month: String) {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "LLLL"  // if you need 3 letter month just use "LLL"
        if let date = df.date(from: month) {
            let monthInt = Calendar.current.component(.month, from: date)
            let components = DateComponents (calendar: Calendar.current, year: 2023, month: monthInt, day: 14)
            let date = NSCalendar.current.date(from: components)
            viewModel.filteredMonth = date!
            monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(components.year!), for: .normal)
        }
        reportCollectionView.reloadData()
    } 
}
