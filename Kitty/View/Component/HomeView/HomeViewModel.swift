//
//  HomeViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation
import RealmSwift

class HomeViewModel {
    var items: [Item]
    var history: [History]
    var income: Double = 0
    var month: [String] = ["January", "February", "March", "April", "May", "Jun", "July", "August", "September", "October", "November", "December"]
    var filteredMonth: Date = Date()
    var database: RealmDatabase = RealmDatabase()
    let userDefaults = UserDefaults.standard
    
    init() {
        self.items = []
        
//        print(items)
        history = database.loadHistoryWithMonth(items: items)
        
        var categories = ["Grocery", "Gifts", "Cafe", "Health", "Commute", "Electronics"]
        let encoder = JSONEncoder()
        if let encodedAray = try? encoder.encode(categories) {
            userDefaults.set(encodedAray, forKey: "categories")
        }
        
//        database.loadItemFireStore(completionHandler: {
//            item in
//            self.items = item
//        })
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
    
    
    func getFilteredHistoryDate(date: Date) -> [History] {
        var result: [History] = []
        for history in history {
            if history.date.month == date.month {
                for item in history.items {
                    if result.firstIndex(where: {$0.date.day == item.date.day}) != nil {
                        let i = result.firstIndex(where: {$0.date.day == item.date.day})!
                        result[i].items.append(item)
                    } else {
                        let newItem: [Item] = [item]
                        let newHistory = History(date: item.date, items: newItem)
                        result.append(newHistory)
                    }
                }
            }
        }
//        print(result)
        return result
    }
    
    func addHistory(newItem: Item, historyName: Date) -> Bool {
        if let found = history.firstIndex(where: {$0.date.month == historyName.month}) {
            history[found].items.append(newItem)
        } else {
            let newHistory = History(date: historyName, items: [newItem])
            self.history.append(newHistory)
        }
        return true
    }
    
    func addItem(newItem: Item) -> Bool {
        items.append(newItem)
        return true
    }
}
