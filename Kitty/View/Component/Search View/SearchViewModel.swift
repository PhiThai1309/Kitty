//
//  SearchViewModel.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import Foundation

class SearchViewModel {
    let userDefaults = UserDefaults.standard
    var categories: [String] = ["Grocery", "Cafe", "Health", "Commute", "Shopping"]
    var filterCat: [String]
    
    var database: RealmDatabase = RealmDatabase()
    
    var filterArray: [Item]
    
    init() {
//        if let savedCategories = userDefaults.object(forKey: "categories") as? Data {
//            let decoder = JSONDecoder()
//            if let saved = try? decoder.decode([String].self, from: savedCategories) {
//                self.categories = saved
//            }
//        }
        filterCat = []
        filterArray = []
    }
    func search(data: String) -> Bool {
        if !filterCat.contains(data) {
            filterCat.append(data)
            filter(array: filterCat)
            return true
        } else {return false}
    }
    
    func remove(data: String) -> Bool {
        if filterCat.contains(data) {
            filterCat.remove(at: filterCat.firstIndex(of: data)!)
            filter(array: filterCat)
            return true
        } else {return false}
    }
    
    func filter(array: [String]) {
        filterArray = database.filterData(categories: array)
    }
}
