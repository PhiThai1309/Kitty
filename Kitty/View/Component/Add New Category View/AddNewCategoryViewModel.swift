//
//  AddNewCategoryViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class AddNewCategoryViewModel {
    let userDefaults = UserDefaults.standard
    
    var categories: [String] = []
    
    init(){
        if let savedCategories = userDefaults.object(forKey: "categories") as? Data {
            let decoder = JSONDecoder()
            if let saved = try? decoder.decode([String].self, from: savedCategories) {
                categories = saved
            }
        }
    }
    
    func addNewCategory(category: String) {
        categories.append(category)
        
        let encoder = JSONEncoder()
        if let encodedAray = try? encoder.encode(categories) {
            userDefaults.set(encodedAray, forKey: "categories")
        }
        
        print(categories)
    }
}
