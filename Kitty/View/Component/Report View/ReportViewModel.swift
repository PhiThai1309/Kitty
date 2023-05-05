//
//  ReportViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation
import OrderedCollections

class ReportViewModel {
    var items: [Item]
    var history: [History]
    var filteredMonth: Date
//    var categories: [[Item]]
    var categoryWithAmount: OrderedDictionary<String, Double> = [:]
    
    init(items: [Item], history : [History], filteredMonth: Date) {
        self.items = items
        self.history = history
        self.filteredMonth = filteredMonth
//        self.categories = categories
    }
    
    func getArrayOfEachCategory() -> [[Item]] {
        var result: [[Item]] = []
        for item in items {
            if item.categoryType == Option.Income {
                continue
            }
            if (result.contains(where: {$0.contains(where: {$0.category!.name == item.category!.name})})) {
                let index = result.firstIndex(where: {$0.contains(where: {$0.category!.name == item.category!.name})})!
                result[index].append(item)
            } else {
                let index = result.count
                result.append([])
                result[index].append(item)
            }
        }
        return result
    }
    
    func countExpenseAmountInCategories() -> OrderedDictionary<String, Double>{
        let array = getArrayOfEachCategory()
        for category in array {
            var sum: Double = 0
            for item in category {
                if item.categoryType == Option.Expenses {
                    sum += item.amount
                    categoryWithAmount[item.category!.name] = sum
                }
            }
        }
        return categoryWithAmount
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
}
