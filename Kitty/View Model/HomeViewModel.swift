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
    
    init(items: [Item], history: [History]) {
        self.items = items
        self.history = history
    }
    
    init() {
        let item1 = Item(category: "cat1", amount: 12.0, description: "Example description")
        let item2 = Item(category: "cat2", amount: 22.0, description: "Example description2")
        let item3 = Item(category: "cat3", amount: 32.0, description: "Example description3")
        
        let hisroty1 = History(date: "Today", amount: 20.0, items: [item1, item2, item3])
        let hisroty2 = History(date: "Today", amount: 20.0, items: [item1, item2, item3])
        history.append(hisroty1)
        history.append(hisroty2)
    }
    
    func getAllItems() -> [Item] {
        return self.items
    }
    
    func getAllHistory() -> [History] {
        return self.history
    }
}
