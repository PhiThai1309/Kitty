//
//  AddNewCategoryViewModel.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class AddNewCategoryViewModel {
    
    var iconArray: [String]
    var remainIconArray: [String]
    var categories: [Category]
    
    init(iconArray: [String], remainIconArray: [String], categories: [Category]) {
        self.iconArray = iconArray
        self.remainIconArray = remainIconArray
        self.categories = categories
    }
    
    func addNewCategory(new: Category) {
        categories.append(new)
    }
    
    func filterIcon() {
        remainIconArray = iconArray.filter { icon in
            return !categories.contains { category in
                return category.name == icon
            }
        }
    }
}
