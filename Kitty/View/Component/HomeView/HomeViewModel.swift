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
    var remainIconArray: [String]
    var month: [String]
    var filteredMonth: Date
    
    init(items: [Item], history: [History], income: Double, remainIconArray: [String], month: [String], filteredMonth: Date) {
        self.items = items
        self.history = history
        self.income = income
        self.remainIconArray = remainIconArray
        self.month = month
        self.filteredMonth = filteredMonth
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
    
    func getFilteredMonth() -> Date {
        return filteredMonth
    }
    
    func setCurrentMonth() {
        filteredMonth = Date()
    }
    
    func setMonth(month: Date) {
        filteredMonth = month
    }
    
    func getIncome() -> Double {
        return income
    }
    
    func getBalance() -> Double {
        return income - getExpense()
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
}
