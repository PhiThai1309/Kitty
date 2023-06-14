//
//  PDFExtension.swift
//  Kitty
//
//  Created by phi.thai on 6/14/23.
//

import Foundation
import PDFKit

extension UIGraphicsPDFRendererContext {
    
    // 1
    func addCenteredText(fontSize: CGFloat,
                         weight: UIFont.Weight,
                         text: String,
                         cursor: CGFloat,
                         pdfSize: CGSize) -> CGFloat {
        
        let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: textFont])
        
        let rect = CGRect(x: pdfSize.width/2 - pdfText.size().width/2, y: cursor, width: pdfText.size().width, height: pdfText.size().height)
        pdfText.draw(in: rect)
        
        return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
    }
    
    // 2
    func addSingleLineText(fontSize: CGFloat,
                           weight: UIFont.Weight,
                           text: String,
                           indent: CGFloat,
                           cursor: CGFloat,
                           pdfSize: CGSize,
                           annotation: PDFAnnotationSubtype?,
                           annotationColor: UIColor?,
                           end: Bool?,
                           title: String) -> CGFloat {
        
        let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let pdfText = NSAttributedString(string: title + text, attributes: [NSAttributedString.Key.font: textFont])
        
        let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2*indent, height: pdfText.size().height)
        pdfText.draw(in: rect)
        
        if let annotation = annotation {
            let annotation = PDFAnnotation(
                bounds: CGRect.init(x: indent, y: rect.origin.y + rect.size.height, width: pdfText.size().width, height: 10),
                forType: annotation,
                withProperties: nil)
            annotation.color = annotationColor ?? .black
            annotation.draw(with: PDFDisplayBox.artBox, in: self.cgContext)
        }
        
        if(end == true) {
            let context = UIGraphicsGetCurrentContext()!
            // 2
            context.saveGState()
              // 3
            context.setLineWidth(0.01)

              // 4
            context.move(to: CGPoint(x: indent, y: rect.origin.y + rect.size.height + 4))
            context.addLine(to: CGPoint(x: indent + rect.size.width, y: rect.origin.y + rect.size.height + 4))
            context.strokePath()
            context.restoreGState()
        }
        
        return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
    }
    
    // 3
    func addMultiLineText(fontSize: CGFloat,
                          weight: UIFont.Weight,
                          text: String,
                          indent: CGFloat,
                          cursor: CGFloat,
                          pdfSize: CGSize) -> CGFloat {
        
        let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping

        let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: textFont])
        let pdfTextHeight = pdfText.height(withConstrainedWidth: pdfSize.width - 2*indent)
        
        let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2*indent, height: pdfTextHeight)
        pdfText.draw(in: rect)

        return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
    }
    
    // 4
    func checkContext(cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
        if cursor > pdfSize.height - 100 {
            self.beginPage()
            return 40
        }
        return cursor
    }
}

extension NSAttributedString {

    // 5
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
    
        return ceil(boundingBox.height)
    }
}
