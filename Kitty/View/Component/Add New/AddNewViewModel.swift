//
//  AddNewViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class AddNewViewModel {
    let userDefaults = UserDefaults.standard
    
    var iconArray: [String]
    var categories: [String] = []
    
    init( iconArray: [String]) {
        self.iconArray = iconArray
        if let savedCategories = userDefaults.object(forKey: "categories") as? Data {
            let decoder = JSONDecoder()
            if let saved = try? decoder.decode([String].self, from: savedCategories) {
                self.categories = saved
            }
        }
    }
    
    func findCategory(name: String) -> String {
        return categories.first(where: {$0 == name})!
    }
}
