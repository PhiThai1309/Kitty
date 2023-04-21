
//
//  ReportViewController.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import Foundation
import Charts

class ReportViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel?
    var sum: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        chartView.delegate = self
        var entries = [BarChartDataEntry]()
        let categories = viewModel?.getArrayOfEachCategory()
        
        for (index, category) in categories!.enumerated() {
            for item in category {
                sum.append(0)
                sum[index] += item.amount
                print(item)
            }
        }
        entries.append (BarChartDataEntry (x: Double(0.1),
                                           yValues: sum))
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
        return viewModel!.getAllHistory().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let amount = viewModel?.getAllCategory()[indexPath.row]

        // Fetch a cell of the appropriate type.
        if let cell = reportCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellView", for: indexPath) as? ItemCollectionViewCell {

            cell.typeLabel.text = amount?.name
            cell.amountLabel.text = String(sum[indexPath.row])
            cell.iconImg.image = UIImage(named: amount!.name)
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
