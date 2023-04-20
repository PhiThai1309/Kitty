//
//  ReportViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import UIKit
import Charts

class ReportViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        chartView.delegate = self
        var entries = [BarChartDataEntry]()
        entries.append (BarChartDataEntry (x: Double(0.1),
                                           yValues: [Double(10), Double(23),Double(99)]))
        let set = BarChartDataSet (entries: entries)
        set.colors = [UIColor.red,UIColor.orange,UIColor.green,UIColor.black,UIColor.blue]
        chartView.animate(yAxisDuration: 0.5)
        let data = BarChartData (dataSet: set)
        chartView.data = data
        
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
        
        let cellNib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        self.reportCollectionView.register(cellNib, forCellWithReuseIdentifier: "ItemCellView")
    }
}

extension ReportViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getAllHistory().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let history = viewModel.getAllHistory()[indexPath.row]
        // Fetch a cell of the appropriate type.
        if let cell = reportCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellView", for: indexPath) as? ItemCollectionViewCell {
            cell.descLabel.text = String(history.amount)
            cell.amountLabel.text = String(history.amount)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _: CGFloat = 1
        let cellWidth = UIScreen.main.bounds.size.width
        return CGSizeMake(cellWidth + 16*2, 50)
    }
}
