//
//  Item.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation

enum type {
    case Expenses
    case Income
}

struct Item {
    var category: Category
    var amount: Double
    var description: String
    var categoryType: type
}
