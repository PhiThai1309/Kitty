//
//  AddNewViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class AddNewViewModel {
    var items: [Item]
    var history: [History]
    var iconArray: [String]
    var remainIconArray: [String]
    var categories: [Category]
    
    init(items: [Item], history : [History], iconArray: [String], remainIconArray: [String], categories: [Category]) {
        self.items = items
        self.history = history
        self.iconArray = iconArray
        self.remainIconArray = remainIconArray
        self.categories = categories
    }
    
    func findCategory(name: String) -> Category {
        return categories.first(where: {$0.name == name})!
    }
    
    func addHistory(newItem: Item, historyName: Date) -> Bool {
        if let found = history.firstIndex(where: {$0.date.month == historyName.month}) {
            history[found].items.append(newItem)
        } else {
            let newHistory = History(date: historyName, items: [newItem])
            self.history.append(newHistory)
        }
        
        items.append(newItem)
        return true
    }
}
