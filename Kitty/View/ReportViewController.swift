
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
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel?
    var sum: Double = 0
    var categoryWithAmount: OrderedDictionary<String, Double> = [:]
    var categories = [[Item]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = (viewModel?.getArrayOfEachCategory())!
        // Do any additional setup after loading the view.
        chartView.delegate = self
        var entries = [BarChartDataEntry]()
        countAmountInCategories()
        let value = Array(categoryWithAmount.values)
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        categories = (viewModel?.getArrayOfEachCategory())!
        countAmountInCategories()
        var entries = [BarChartDataEntry]()
        let value = Array(categoryWithAmount.values)
        entries.append (BarChartDataEntry (x: Double(0.1),
                                           yValues: value))
        let set = BarChartDataSet (entries: entries)
        set.colors = [UIColor.red,UIColor.orange,UIColor.green,UIColor.black,UIColor.blue]
        chartView.animate(yAxisDuration: 0.5)
        let data = BarChartData (dataSet: set)
        chartView.data = data
        chartView.animate(yAxisDuration: 0.5)
        reportCollectionView.reloadData()
        chartTheme() 
    }
    
    func countAmountInCategories() {
        print(categories)
        for (index, category) in categories.enumerated() {
            sum = 0
            for item in category {
                sum += item.amount
                categoryWithAmount[item.category.name] = sum
            }
            
        }
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
}

extension ReportViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let amount = categories[indexPath.row]

        // Fetch a cell of the appropriate type.
        if let cell = reportCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellView", for: indexPath) as? ItemCollectionViewCell {

            cell.typeLabel.text = amount[0].category.name
            cell.amountLabel.text = String(Array(categoryWithAmount)[indexPath.row].value)
            cell.iconImg.image = UIImage(named: amount[0].category.name)
            let categories = viewModel?.getArrayOfEachCategory()

            cell.descLabel.text = String(categories![indexPath.row].count) + " transactions"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _: CGFloat = 1
        let cellWidth = UIScreen.main.bounds.size.width
        return CGSizeMake(cellWidth, 50)
    }
}
