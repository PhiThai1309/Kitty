//
//  SettingViewModel.swift
//  Kitty
//
//  Created by phi.thai on 6/15/23.
//

import Foundation
import PDFKit

class SettingsViewModel {
    var items: [Item]
    var database: RealmDatabase = RealmDatabase()
    
    init() {
        self.items = []
    }
    
    func loadData() {
        database.loadItemFireStore(completionHandler: {
            item in
            self.items = item
        })
     }
    
    //MARK: PDF secction
    func generateDrinkText(item: Item, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .bold, text: item.desc!, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Description: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: String(item.amount), indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Amount: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text:  item.date.day + " " + item.date.month + " 2023", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Date: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.category, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: nil, title: "Category: ")
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: item.categoryType.rawValue, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil, end: true, title: "Category Type: ")

            cursor+=20
        return cursor
    }
    
    func generatePdfData(items: [Item]) -> Data {
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
            
            if items.isEmpty {
                cursor = context.addCenteredText(fontSize: 14, weight: .thin, text: "No expense history tracked", cursor: cursor, pdfSize: pageRect.size)
                    cursor+=6
            } else {
                
            for data in items {
                // wirte in our context the info of each drink
                cursor = generateDrinkText(item: data, context: context, cursorY: cursor, pdfSize: pageRect.size)
            }
            cursor+=10
            }
        }
        return data
    }
}
