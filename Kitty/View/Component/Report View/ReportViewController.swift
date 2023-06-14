
//
//  ReportViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import Foundation
import Charts
import OrderedCollections
import PDFKit

class ReportViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    lazy var viewModel: ReportViewModel = {
        return ReportViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        
        viewModel.fetchData()
        viewModel.delegate = self
        
        let cellNib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        self.reportCollectionView.register(cellNib, forCellWithReuseIdentifier: "ItemCellView")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
    func setupChart() {
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
        
        let data = BarChartData (dataSet: set)
        chartView.data = data
        chartView.animate(yAxisDuration: 0.5)
        chartTheme()
        reportCollectionView.reloadData()
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
        viewModel.reloadData()
        setupChart()
    }
    
    @IBAction func leftOnClickHandler(_ sender: Any) {
        let year = viewModel.backAMonth()
        monthBtn.setTitle(viewModel.filteredMonth.month + ", " + String(year), for: .normal)
        viewModel.reloadData()
        setupChart()
    }
    
    @IBAction func generateReport(_ sender: Any) {
        let pdfData = viewModel.generatePdfData(items: viewModel.categoryReport)
        let newViewController = PDFViewController()
        newViewController.documentData = pdfData
        self.present(newViewController, animated: true)
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
            
            cell.descLabel.text = String(viewModel.categoryReport[indexPath.row].count) + " transactions"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = reportCollectionView.frame.width
        return CGSizeMake(width - 4, 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        print(viewModel.categoryReport[indexPath.row])s
        let storyboard = UIStoryboard(name: "ReportDetailsView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReportDetailsView") as! ReportDetailsView
        
        vc.items = viewModel.categoryReport[indexPath.row].reversed()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
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
        viewModel.reloadData()
        setupChart()
        reportCollectionView.reloadData()
    }
}

extension ReportViewController: ReportViewModelDelegate {
    func reloadTable() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: self.viewModel.filteredMonth)
        
        self.monthBtn.setTitle(self.viewModel.filteredMonth.month + ", " + String(calendarDate.year!), for: .normal)
        
        self.reportCollectionView.reloadData()
        self.setupChart()
    }
}
