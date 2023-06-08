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
    var categoryReport: [[Item]]
    var categoryWithAmount: OrderedDictionary<String, Double> = [:]
    var database: RealmDatabase = RealmDatabase()
    
    init() {
        items = []
        categoryReport = []
        history = database.loadHistoryWithMonth(items: items)
        self.filteredMonth = Date()
    }
    
    func fetchData() {
        categoryReport = getArrayOfEachCategory()
        countExpenseAmountInCategories()
        
//        items = database.loadItem()
        history = database.loadHistoryWithMonth(items: items)
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
}
