//
//  ReportViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation
import OrderedCollections
import PDFKit

protocol ReportViewModelDelegate {
    func reloadTable()
}

class ReportViewModel {
    var items: [Item]
    var history: [History]
    var filteredMonth: Date
    var categoryReport: [[Item]]
    var categoryWithAmount: OrderedDictionary<String, Double> = [:]
    var arrayForChosenMonth: [Item]
    var database: RealmDatabase = RealmDatabase()
    var delegate: ReportViewModelDelegate?
    init() {
        items = []
        categoryReport = []
        history = database.loadHistoryWithMonth(items: items)
        self.filteredMonth = Date()
        arrayForChosenMonth = []
    }
    
    func fetchData() {
        database.loadItemFireStore(completionHandler: {
            item in
            self.items = item
            
            self.categoryReport = self.getArrayOfEachCategory()
            self.countExpenseAmountInCategories()
            self.history = self.database.loadHistoryWithMonth(items: self.items)
            
            DispatchQueue.main.async {
                self.delegate?.reloadTable()
            }
        })
        
    }
    
    func reloadData() {
        categoryReport = getArrayOfEachCategory()
        countExpenseAmountInCategories()
    }
    
    func getArrayOfEachCategory() -> [[Item]] {
        var result: [[Item]] = []
        for item in items {
            if item.categoryType == Option.Income || item.date.month != filteredMonth.month{
                continue
            }
            if (result.contains(where: {$0.contains(where: {$0.category == item.category})})) {
                let index = result.firstIndex(where: {$0.contains(where: {$0.category == item.category})})!
                result[index].append(item)
            } else {
                let index = result.count
                result.append([])
                result[index].append(item)
            }
            arrayForChosenMonth.append(item)
        }
        return result
    }
    
    func countExpenseAmountInCategories(){
        let array = getArrayOfEachCategory()
        categoryWithAmount = [:]
        for category in array {
            var sum: Double = 0
            for item in category {
                if item.categoryType == Option.Expenses {
                    sum += item.amount
                    categoryWithAmount[item.category] = sum
                }
            }
        }
    }
    
    func addAMonth() -> Int{
        let monthInt = Calendar.current.component(.month, from: filteredMonth)
        let components = DateComponents (calendar: Calendar.current, year: 2023, month: monthInt + 1, day: 14)
        let date = NSCalendar.current.date(from: components)
        filteredMonth = date!
        return components.year!
    }
    
    func backAMonth() -> Int{
        let monthInt = Calendar.current.component(.month, from: filteredMonth)
        let components = DateComponents (calendar: Calendar.current, year: 2023, month: monthInt - 1, day: 14)
        let date = NSCalendar.current.date(from: components)
        filteredMonth = date!
        return components.year!
    }
    
    func generateDrinkText(item: Item, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.desc!, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Description: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: String(item.amount), indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: true, title: "Amount: ")

            cursor+=10
        return cursor
    }
    
    func generatePdfData(items: [[Item]]) -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "theuser", // Creator of the PDF Document
            kCGPDFContextAuthor: "Kitty Application", // The Author
            kCGPDFContextTitle: "Expense report" // PDF Title
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8) // Page size is set to A4
        let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format) // Renderer that allows us to configure context
        
        let data = graphicsRenderer.pdfData { (context) in
            context.beginPage() // start a new page for the PDF
            
            let initialCursor: CGFloat = 32 // cursor is used to track the max y coordinate of our PDF to know where to append new text
            
            // Adding a title
            var cursor = context.addCenteredText(fontSize: 32, weight: .bold, text: filteredMonth.month + ", 2023 report", cursor: initialCursor, pdfSize: pageRect.size)
            
            cursor+=42 // Add white space after the Title
            
            for category in items {
                cursor = context.addSingleLineText(fontSize: 14, weight: .bold, text:  category[0].category, indent: 74, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: nil, end: nil, title: "")
                    cursor+=6
                for item in category {
                    // wirte in our context the info of each drink
                    cursor = generateDrinkText(item: item, context: context, cursorY: cursor, pdfSize: pageRect.size)
                }
                cursor+=10
            }
        }
        return data
    }
}
