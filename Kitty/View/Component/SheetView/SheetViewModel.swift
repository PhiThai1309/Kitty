//
//  SheetViewViewMode.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class SheetViewModel {
    let userDefaults = UserDefaults.standard
    
    
    lazy var iconArray: [String] = {
        return Icon().iconArray
    }()
    
    var categories: [String] = []
    
    init(){
        refreshData()
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
