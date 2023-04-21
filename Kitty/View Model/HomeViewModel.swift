//
//  HomeViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation

class HomeViewModel {
    private var items: [Item] = []
    private var history: [History] = []
    private var categories: [Category] = []
    
    init(items: [Item], history: [History]) {
        self.items = items
        self.history = history
    }
    
    init() {
        let category1  = Category(name: "Grocery")
        let category2 = Category(name: "Gifts")
        let category3  = Category(name: "Bar & Cafe")
        categories.append(category3)
        categories.append(category2)
        categories.append(category1)
        
        let item1 = Item(category: category1, amount: 120.0, description: "Example description", categoryType: type.Expenses)
        let item2 = Item(category: category2, amount: 22.0, description: "Example description2", categoryType: type.Expenses)
        let item3 = Item(category: category3, amount: 32.0, description: "Example description3", categoryType: type.Expenses)
        let item4 = Item(category: category3, amount: 32.0, description: "Example description3", categoryType: type.Expenses)
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        
        let hisroty1 = History(date: "hisroty1", amount: 20.0, items: [item1, item3])
        let hisroty2 = History(date: "hisroty2", amount: 20.0, items: [item2])
        let hisroty3 = History(date: "hisroty3", amount: 20.0, items: [item4])
        history.append(hisroty1)
        history.append(hisroty2)
        history.append(hisroty3)
        
    }
    
    func getAllItems() -> [Item] {
        return self.items
    }
    
    func getAllHistory() -> [History] {
        return self.history
    }
    
    func getAllCategory() -> [Category] {
        return categories
    }
    
    func getArrayOfEachCategory() -> [[Item]] {
        var result = [[Item]]()
        for item in items {
            for (index, category) in categories.enumerated() {
//                if (result[index] == nil) {
//                    result.append([])
//                }
                result.append([])
                if (item.category.name == category.name) {
                    result[index].append(item)
                }
            }
        }
        return result
    }
}
