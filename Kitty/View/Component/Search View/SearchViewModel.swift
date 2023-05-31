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
        filterCat = []
        filterArray = database.loadItem()
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
                if !item.category.localizedStandardContains(query) || !((item.desc?.localizedStandardContains(query)) != nil) {
                    filterArray.remove(at: filterArray.firstIndex(of: item)!)
                } else {

                }
            }
        }
    }
    
    func clearData() {
        filterArray.removeAll()
        filterArray = database.loadItem()
    }
}
