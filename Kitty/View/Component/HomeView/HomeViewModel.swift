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
    
    init() {
        self.items = DummyItem().items
        self.history = []
        self.income = 500
        self.month = ["January", "February", "March", "April", "May", "Jun", "July", "August", "September", "October", "November", "December"]
        self.filteredMonth = Date()
    }
    
//    init() {
//        let components = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 4)
//        let date = NSCalendar.current.date(from: components)
//
//        let components2 = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 6)
//        let date2 = NSCalendar.current.date(from: components2)
//
//        let components3 = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 1)
//        let date3 = NSCalendar.current.date(from: components3)
//
//        let history1 = History(date: date!, items: [item1, item3])
//        let history2 = History(date: date2!, items: [item2])
//        let history3 = History(date: date3!, items: [item4])
//
//        history.append(history1)
//        history.append(history2)
//        history.append(history3)
//
//    }
    
    func loadHistory(){
        var result = [History]()
        for item in items {
            if result.firstIndex(where: {$0.date == item.date}) != nil {
                let i = result.firstIndex(where: {$0.date == item.date})!
                result[i].items.append(item)
            } else {
                let newItem: [Item] = [item]
                let newHistory = History(date: item.date, items: newItem)
                result.append(newHistory)
            }
        }
        history = result
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
        for item in history {
            if item.date.month == date.month {
                result.append(item)
            }
        }
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
