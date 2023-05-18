//
//  CategorySheetViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class CategorySheetViewModel {
    var categories: [String]
    
    var remainIconArray: [String] = []
    
    var iconArray: [String] = {
        return Icon().iconArray
    }()
    
    init(categories: [String]){
        self.categories = categories
    }
    
    func filterIcon() {
        remainIconArray = iconArray.filter { icon in
            return !categories.contains { category in
                return category == icon
            }
        }
    }
}
