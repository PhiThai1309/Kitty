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
    private var categories: [String] = []
    private var income: Double = 500
    private var iconArray: [String] = []
    private var remainIconArray: [String] = []
    private var month: [String] = []
    
    private var filteredMonth = Date()
    
    let userDefaults = UserDefaults.standard
    
    init() {
        month = ["January", "February", "March", "April", "May", "Jun", "July", "August", "September", "October", "November", "December"]
        
        
        
        
        
        
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

    func getAllCategory() -> [String] {
        return categories
    }
    
    func getCategoryWithAmount() -> [String] {
        var amountCategory: [String] = []
//        for item in items {
//            if !amountCategory.contains(where: {$0.name == item.category}) {
//                amountCategory.append(item.category)
//            }
//        }
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
