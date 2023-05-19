//
//  SearchViewModel.swift
//  Kitty
//
//  Created by phi.thai on 5/19/23.
//

import Foundation

class SearchViewModel {
    let userDefaults = UserDefaults.standard
    var categories: [String] = []
    
    init() {
        if let savedCategories = userDefaults.object(forKey: "categories") as? Data {
            let decoder = JSONDecoder()
            if let saved = try? decoder.decode([String].self, from: savedCategories) {
                self.categories = saved
            }
        }
    }
}
