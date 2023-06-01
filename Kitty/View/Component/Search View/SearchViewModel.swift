//
//  SearchViewModel.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import Foundation

class SearchViewModel {
    let userDefaults = UserDefaults.standard
    var availableCategories: [String]
    var categories: [String] = ["Grocery", "Cafe", "Health", "Commute", "Gifts"]
    var filterCat: [String]
    
    var database: RealmDatabase = RealmDatabase()
    
    var filterArray: [Item]
    
    init() {
        filterCat = []
        filterArray = database.loadItem()
        availableCategories = []
        checkCategories(data: filterArray)
    }
    
    func checkCategories(data: [Item]) {
        var result = [String]()
        for category in data {
            if !result.contains(category.category) {
                result.append(category.category)
            }
        }
        if result.isEmpty {
            categories = ["Grocery", "Cafe", "Health", "Commute", "Gifts"]
        } else {
            categories = result
        }
        print(categories)
    }
    
    func remove(data: String, query: String) {
        if filterCat.contains(data) {
            filterCat.remove(at: filterCat.firstIndex(of: data)!)
            searchAdvance(query: query, data: "")
        }
    }
    
    func searchAdvance(query: String, data: String) {
        if !filterCat.contains(data) && data != ""{
            filterCat.append(data)
        }
        
        if !filterCat.isEmpty {
            filterArray = database.filterData(categories: filterCat)
        } else {
            filterArray = database.loadItem()
        }
        
        print(filterArray)
        if query != "" {
            for item in filterArray {
                print(item.desc!)
                if (!item.category.localizedStandardContains(query) && !(item.desc!.localizedStandardContains(query) && item.desc != nil)){
                    filterArray.remove(at: filterArray.firstIndex(of: item)!)
                }
            }
        }
    }
    
    func clearData() {
        filterArray.removeAll()
        if !filterCat.isEmpty {
            filterArray = database.filterData(categories: filterCat)
        } else {
            filterArray = database.loadItem()
        }
    }
}
