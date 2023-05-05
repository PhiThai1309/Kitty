//
//  HomeViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import OrderedCollections
import RealmSwift

class MainViewModel {
    private var items: [Item] = []
    private var history: [History] = []
    private var categories: [Category] = []
    private var income: Double = 500
    private var iconArray: [String] = []
    private var remainIconArray: [String] = []
    private var month: [String] = []
    
    private var filteredMonth = Date()
    
    init() {
        iconArray = ["Grocery","Gifts","Cafe","Health","Electronics", "Commute", "Donate", "Education", "Self development", "Fuel", "Institute", "Laundry", "Liquor", "Maintenance", "Cash", "Party", "Restaurant", "Savings", "Sport"]
        
        month = ["January", "February", "March", "April", "May", "Jun", "July", "August", "September", "October", "November", "December"]
        
        let category1 = Category(name: "Grocery")
        let category2 = Category(name: "Gifts")
        let category3 = Category(name: "Cafe")
        let category4 = Category(name: "Health")
        let category5 = Category(name: "Commute")
        let category6 = Category(name: "Electronics")
        categories.append(category3)
        categories.append(category2)
        categories.append(category1)
        categories.append(category4)
        categories.append(category5)
        categories.append(category6)
        
        let item1 = Item(category: category1, amount: 120.0, description: "Example description", categoryType: Option.Expenses)
        let item2 = Item(category: category3, amount: 22.0, description: "Example description2", categoryType: Option.Expenses)
        let item3 = Item(category: category3, amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        let item4 = Item(category: category4, amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        
        let components = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 4)
        let date = NSCalendar.current.date(from: components)
        
        let components2 = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 6)
        let date2 = NSCalendar.current.date(from: components2)
        
        let components3 = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 1)
        let date3 = NSCalendar.current.date(from: components3)
        
        let history1 = History(date: date!, items: [item1, item3])
        let history2 = History(date: date2!, items: [item2])
        let history3 = History(date: date3!, items: [item4])
        
        history.append(history1)
        history.append(history2)
        history.append(history3)
        
//        filterIcon()
        
        // Open the local-only default realm
//        let realm = try! Realm()
//        
//        try! realm.write {
//            print("can write")
//            realm.add(history1)
//        }
        
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
    

    

    

    
    
    //MARK: Getter, Setter
    func getCurrentMonth() -> Date {
        return filteredMonth
    }
    
    func setCurrentMonth(month: Date) {
        filteredMonth = month
    }
    
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
    
    func getRemainIconArray() -> [String] {
        return self.remainIconArray
    }

    func getAllCategory() -> [Category] {
        return categories
    }
    
    func getCategoryWithAmount() -> [Category] {
        var amountCategory: [Category] = []
        for item in items {
            if !amountCategory.contains(where: {$0.name == item.category!.name}) {
                amountCategory.append(item.category!)
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

    
    func getIncome() -> Double {
        var result = income
        for item in items {
            if item.categoryType == Option.Income {
                result += item.amount
            }
        }
        return result
    }
}
