//
//  PDFViewModel.swift
//  Kitty
//
//  Created by phi.thai on 6/16/23.
//

import Foundation
import PDFKit

class PDFViewModel {
    var pdfData: Data?
    var items: [Item]
    public var categoryReport: [[Item]]
    public var dateReport: [[Item]]
    
    init(items: [Item]) {
        self.items = items
        categoryReport = []
        dateReport = []
    }
    
    func getArrayOfEachCategory(){
        var result: [[Item]] = []
        for item in items {
            if (result.contains(where: {$0.contains(where: {$0.category == item.category})})) {
                let index = result.firstIndex(where: {$0.contains(where: {$0.category == item.category})})!
                result[index].append(item)
            } else {
                let index = result.count
                result.append([])
                result[index].append(item)
            }
        }
        categoryReport = result
    }
    
    func getArrayByDate(){
        var result: [[Item]] = []
        for item in items {
            if (result.contains(where: {$0.contains(where: {$0.date.month == item.date.month})})) {
                let index = result.firstIndex(where: {$0.contains(where: {$0.date.month == item.date.month})})!
                result[index].append(item)
            } else {
                let index = result.count
                result.append([])
                result[index].append(item)
            }
        }
        dateReport = result
    }
    
    
    
    //MARK: PDF secction
    func generateTextCategory(item: Item, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text:  item.date.day + " " + item.date.month + " 2023", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Date: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.desc!, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Description: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: String(item.amount), indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Amount: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.category, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Category: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.categoryType.rawValue, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: true, title: "Category Type: ")

            cursor+=20
        return cursor
    }
    
    func generateTextItem(item: Item, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.date.month + ", " + item.date.day, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Date: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.desc!, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Description: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: String(item.amount), indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Amount: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.categoryType.rawValue, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: true, title: "Categoory Type: ")

            cursor+=10
        return cursor
    }
    
    func generateTextDate(item: Item, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.desc!, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Description: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: String(item.amount), indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Amount: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.category, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Category: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.categoryType.rawValue, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: true, title: "Categoory Type: ")

            cursor+=10
        return cursor
    }
    
    func generatePdfData(itemsArray: [[Item]]?, items: [Item]?, date: Bool) -> Data {
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
            var cursor = context.addCenteredText(fontSize: 32, weight: .bold, text: "2023 report", cursor: initialCursor, pdfSize: pageRect.size)
            
            cursor+=42 // Add white space after the Title
            if let item = itemsArray {
                if item.isEmpty {
                    cursor = context.addCenteredText(fontSize: 14, weight: .thin, text: "No expense history tracked", cursor: cursor, pdfSize: pageRect.size)
                        cursor+=6
                } else {
                    if date {
                        for category in item {
                            cursor = context.addSingleLineText(fontSize: 14, weight: .bold, text:  category[0].date.month, indent: 74, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: nil, end: nil, title: "")
                                cursor+=6
                            for item in category {
                                // wirte in our context the info of each drink
                                cursor = generateTextDate(item: item, context: context, cursorY: cursor, pdfSize: pageRect.size)
                            }
                            cursor+=10
                        }
                    } else {
                        for category in item {
                            cursor = context.addSingleLineText(fontSize: 14, weight: .bold, text:  category[0].category, indent: 74, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: nil, end: nil, title: "")
                                cursor+=6
                            for item in category {
                                // wirte in our context the info of each drink
                                cursor = generateTextItem(item: item, context: context, cursorY: cursor, pdfSize: pageRect.size)
                            }
                            cursor+=10
                        }
                    }
                }
            }
            
            if let item = items {
                if item.isEmpty {
                    cursor = context.addCenteredText(fontSize: 14, weight: .thin, text: "No expense history tracked", cursor: cursor, pdfSize: pageRect.size)
                        cursor+=6
                } else {
                    
                for data in item {
                    // wirte in our context the info of each drink
                    cursor = generateTextCategory(item: data, context: context, cursorY: cursor, pdfSize: pageRect.size)
                }
                cursor+=10
                }
            }
        }
        return data
    }
}
