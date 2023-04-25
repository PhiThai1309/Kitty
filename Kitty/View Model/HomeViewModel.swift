//
//  HomeViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import OrderedCollections

class HomeViewModel {
    private var items: [Item] = []
    private var history: [History] = []
    private var categories: [Category] = []
    private var income: Double = 500
    private var iconArray: [String] = []
    private var remainIconArray: [String] = []
    private var month: [String] = []
    
    private var categoryWithAmount: OrderedDictionary<String, Double> = [:]
    
    init(items: [Item], history: [History]) {
        self.items = items
        self.history = history
    }
    
    init() {
        iconArray = ["Grocery","Gifts","Cafe","Health","Electronics", "Commute", "Donate", "Education", "Self development", "Fuel", "Institute", "Laundry", "Liquor", "Maintenance", "Cash", "Party", "Restaurant", "Savings", "Sport"]
        
        month = ["January", "February", "March", "April", "May", "Jun", "July", "August", "September", "October", "November", "December"]
        
        let category1  = Category(name: "Grocery")
        let category2 = Category(name: "Gifts")
        let category3  = Category(name: "Cafe")
        let category4  = Category(name: "Health")
        let category5  = Category(name: "Commute")
        let category6  = Category(name: "Electronics")
        categories.append(category3)
        categories.append(category2)
        categories.append(category1)
        categories.append(category4)
        categories.append(category5)
        categories.append(category6)
        
        let item1 = Item(category: category1, amount: 120.0, description: "Example description", categoryType: Option.Expenses)
        let item2 = Item(category: category2, amount: 22.0, description: "Example description2", categoryType: Option.Expenses)
        let item3 = Item(category: category3, amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        let item4 = Item(category: category3, amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        
        let components = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 1)
        let date = NSCalendar.current.date(from: components)
        
        let components2 = DateComponents (calendar: Calendar.current, year: 2023, month: 2, day: 1)
        let date2 = NSCalendar.current.date(from: components2)
        
        let components3 = DateComponents (calendar: Calendar.current, year: 2023, month: 1, day: 1)
        let date3 = NSCalendar.current.date(from: components3)
        
        let hisroty1 = History(date: date!, amount: 20.0, items: [item1, item3])
        let hisroty2 = History(date: date2!, amount: 20.0, items: [item2])
        let hisroty3 = History(date: date3!, amount: 20.0, items: [item4])
        history.append(hisroty1)
        history.append(hisroty2)
        history.append(hisroty3)
        
        filterIcon()
        
    }
    
    //MARK: Filter
    func filterExpense(item: [Item]) -> [Item] {
        var result: [Item] = []
        for value in item {
            if(value.categoryType == Option.Expenses) {
                result.append(value)
            }
        }
        return result
    }
    
    func filterIcon() {
        remainIconArray = iconArray.filter { icon in
            return !categories.contains { category in
                return category.name == icon
            }
        }
    }
    
    func addHistory(newItem: Item, historyName: Date) -> Bool {
        if let found = history.firstIndex(where: {$0.date.month == historyName.month}) {
            history[found].items.append(newItem)
        } else {
            let newHistory = History(date: historyName, amount: 0, items: [newItem])
            self.history.append(newHistory)
        }
        
        items.append(newItem)
        return true
    }
    
    func findCategory(name: String) -> Category {
        return categories.first(where: {$0.name == name})!
    }
    
    
    //MARK: Getter, Setter
    func getAllMonth() -> [String] {
        return month
    }
    
    func getAllIcon() -> [String] {
        return remainIconArray
    }
    
    func getAllItems() -> [Item] {
        return self.items
    }
    
    func getAllHistory() -> [History] {
        return self.history
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

    func getAllCategory() -> [Category] {
        return categories
    }
    
    func getCategoryWithAmount() -> [Category] {
        var amountCategory: [Category] = []
        for item in items {
            if !amountCategory.contains(where: {$0.name == item.category.name}) {
                amountCategory.append(item.category)
            }
        }
        return amountCategory
    }
    
    func getHistoryAmount() -> [Double] {
        var sum: [Double] = []
        for (index, object) in history.enumerated() {
            for amount in object.items {
                sum.append(0)
                sum[index] = sum[index] + amount.amount
            }
        }
        return sum
    }
    

    
    //MARK: Money manage logic
    func getExpense() -> Double {
        var sum: Double = 0
        for item in items {
            if item.categoryType == Option.Expenses{
                sum += item.amount
            }
        }
        return sum
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
    
    func addNewCategory(new: Category) {
        categories.append(new)
    }
    
    //MARK: Other
    func countExpenseAmountInCategories() -> OrderedDictionary<String, Double>{
        let array = getArrayOfEachCategory()
        for category in array {
            var sum: Double = 0
            for item in category {
                if item.categoryType == Option.Expenses {
                    sum += item.amount
                    categoryWithAmount[item.category.name] = sum
                }
            }
        }
        return categoryWithAmount
    }
    
    func getArrayOfEachCategory() -> [[Item]] {
        var result: [[Item]] = []
        for item in items {
            if item.categoryType == Option.Income {
                continue
            }
            if (result.contains(where: {$0.contains(where: {$0.category.name == item.category.name})})) {
                let index = result.firstIndex(where: {$0.contains(where: {$0.category.name == item.category.name})})!
                result[index].append(item)
            } else {
                let index = result.count
                result.append([])
                result[index].append(item)
            }
        }
        return result
    }
}
