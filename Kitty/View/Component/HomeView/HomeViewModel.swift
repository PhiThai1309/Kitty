//
//  HomeViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class HomeViewModel {
    var items: [Item]
    var history: [History]
    var income: Double
    var month: [String]
    var filteredMonth: Date
    var database: FireStoreDatabase
    
    init(items: [Item], history: [History], income: Double, month: [String], filteredMonth: Date) {
        self.items = items
        self.history = history
        self.income = income
        self.month = month
        self.filteredMonth = filteredMonth
        self.database = FireStoreDatabase()
    }
    
    func getExpense() -> Double {
        var sum: Double = 0
        for item in items {
            if item.categoryType == Option.Expenses{
                sum += item.amount
            }
        }
        return sum
    }
    
    func setCurrentMonth() {
        filteredMonth = Date()
    }
    
    func setMonth(month: Date) {
        filteredMonth = month
    }
    
    func getIncome() -> Double {
        var result = income
        for item in items {
            if item.categoryType == Option.Income {
                result += item.amount
            }
        }
        return result
    }
    
    func getBalance() -> Double {
        return getIncome() - getExpense()
    }
    
    func convertToNormalDate() -> String {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: filteredMonth)
        return filteredMonth.month + ", " + String(calendarDate.year!)
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
    
    
    func getFilteredHistory(date: Date) -> [History] {
        var result: [History] = []
//        for item in history {
//            if item.date.month == date.month {
//                result.append(item)
//            }
//        }
        return result
    }
    
    func addHistory(newItem: Item, historyName: Date) -> Bool {
//        if let found = history.firstIndex(where: {$0.date.month == historyName.month}) {
//            history[found].items.append(newItem)
//        } else {
//            let newHistory = History(date: historyName, items: [newItem])
//            self.history.append(newHistory)
//        }
        return true
    }
    
    func addItem(newItem: Item) -> Bool {
        items.append(newItem)
        return true
    }
}
