//
//  SheetViewViewMode.swift
//  Kitty
//
//  Created by phi.thai on 4/27/23.
//

import Foundation

class SheetViewModel {
    lazy var iconArray: [String] = {
        return Icon().iconArray
    }()
    
    @Published var categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
    }
    
    func addNewCategory(new: Category) {
        categories.append(new)
    }
}
