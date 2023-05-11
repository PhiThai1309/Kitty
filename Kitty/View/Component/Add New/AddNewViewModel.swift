//
//  AddNewViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class AddNewViewModel {
    let userDefaults = UserDefaults.standard
    
    var items: [Item]
    var history: [History]
    var iconArray: [String]
    var categories: [Category] = []
    
    init(items: [Item], history : [History], iconArray: [String]) {
        self.items = items
        self.history = history
        self.iconArray = iconArray
        if let savedCategories = userDefaults.object(forKey: "categories") as? Data {
            let decoder = JSONDecoder()
            if let saved = try? decoder.decode([Category].self, from: savedCategories) {
                self.categories = saved
            }
        }
    }
    
    func findCategory(name: String) -> Category {
        return categories.first(where: {$0.name == name})!
    }
}
