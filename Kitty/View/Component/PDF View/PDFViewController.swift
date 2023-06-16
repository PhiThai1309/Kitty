//
//  PDFViewController.swift
//  Kitty
//
//  Created by phi.thai on 6/14/23.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    public var segmentedOption: String = "Item"
    public var items: [Item]?
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    lazy var viewModel: PDFViewModel = {
        return PDFViewModel(items: items!)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.prompt = "Generated report"
        
        renderPDF()
        
        viewModel.getArrayOfEachCategory()
        viewModel.getArrayByDate()
    }
    
    func renderPDF() {
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        pdfView.pageBreakMargins = UIEdgeInsets.init(top: 20, left: 8, bottom: 32, right: 8)
        switch segmentedOption {
        case "Item":
            viewModel.pdfData = viewModel.generatePdfData(itemsArray: nil, items: viewModel.items, date: false)
            pdfView.document = PDFDocument(data: viewModel.pdfData!)
        case "Category":
            viewModel.pdfData = viewModel.generatePdfData(itemsArray: viewModel.categoryReport, items: nil, date: false)
            pdfView.document = PDFDocument(data: viewModel.pdfData!)
        case "Date":
            viewModel.pdfData = viewModel.generatePdfData(itemsArray: viewModel.dateReport, items: nil, date: true)
            pdfView.document = PDFDocument(data: viewModel.pdfData!)
        default:
            break
        }
    }
    
    @IBAction func share(_ sender: Any) {
        let vc = UIActivityViewController(
          activityItems: [viewModel.pdfData!],
          applicationActivities: []
        )
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.popoverPresentationController?.barButtonItem = shareButton
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func segmentOnClick(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                print("Segment 0 is selected")
                segmentedOption = "Item"
                renderPDF()
            case 1:
                print("Segment 1 is selected")
                segmentedOption = "Category"
                renderPDF()
            case 2:
                print("Segment 2 is selected")
                segmentedOption = "Date"
                renderPDF()
            default:
                break
            }
    }
}
