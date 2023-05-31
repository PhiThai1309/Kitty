//
//  ManageCategoriesViewModel.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import Foundation

class ManageCategoriesViewModel {
    let userDefaults = UserDefaults.standard
    
    var categories: [String] = []
    var remainIconArray: [String] = []
    
    var iconArray: [String] = {
        return Icon().iconArray
    }()
    
    init(){
        if let savedCategories = userDefaults.object(forKey: "categories") as? Data {
            let decoder = JSONDecoder()
            if let saved = try? decoder.decode([String].self, from: savedCategories) {
                categories = saved
            }
        }
        categories = categories.reversed()
    }
    
    func filterIcon() {
        remainIconArray = iconArray.filter { icon in
            return !categories.contains { category in
                return category == icon
            }
        }
    }
    
    func moveCategory(move: Int, path: Int) {
        let original = categories.remove(at: move)
        categories.insert(original, at: path)
    }
    
    func saveChanges() {
        let encoder = JSONEncoder()
        if let encodedAray = try? encoder.encode(categories.reversed()) {
            userDefaults.set(encodedAray, forKey: "categories")
        }
//        print(categories.reversed())
    }
    
    func refreshData() {
        if let savedCategories = userDefaults.object(forKey: "categories") as? Data {
            let decoder = JSONDecoder()
            if let saved = try? decoder.decode([String].self, from: savedCategories) {
                categories = saved
            }
        }
        categories = categories.reversed()
    }
}
