//
//  SearchViewModel.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import Foundation

protocol SearchViewModelDelegate {
    func loadData()
}

class SearchViewModel {
    let userDefaults = UserDefaults.standard
    var categories: [String] = ["Grocery", "Cafe", "Health", "Commute", "Gifts"]
    var filterCat: [String]
    
    var database: RealmDatabase = RealmDatabase()
    
    var filterArray: [Item]
    var originalArray: [Item]
    
    var delegate: SearchViewModelDelegate?
    
    init() {
        filterCat = []
        filterArray = []
        originalArray = []
    }
    
    func loadData() {
        database.loadItemFireStore(completionHandler: {
            item in
            self.filterArray = item.reversed()
            self.originalArray = item.reversed()
            self.checkCategories(data: self.filterArray)
            DispatchQueue.main.async {
                self.delegate?.loadData()
            }
        })
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
        print(filterCat)
        if !filterCat.isEmpty {
            filterArray = database.filterData(categories: filterCat, array: originalArray)
        } else {
            filterArray = originalArray
        }
        
        if query != "" {
            for item in filterArray {
                if (!item.category.localizedStandardContains(query) && !(item.desc!.localizedStandardContains(query) && item.desc != nil)){
                    filterArray.remove(at: filterArray.firstIndex(of: item)!)
                }
            }
        }
    }
    
    func clearData() {
        filterArray.removeAll()
        if !filterCat.isEmpty {
            filterArray = database.filterData(categories: filterCat, array: originalArray)
        } else {
            filterArray = originalArray
        }
    }
}
