//
//  Item.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift
import Realm

enum Option: String {
    case Expenses
    case Income
}

@objcMembers class Item: Object {
    var category: Category = Category(name: "")
    var amount: Double = 0.0
    var desc: String?
    var categoryType: Option = Option.Expenses
    
    init(amount: Double, description: String? = nil) {
        self.amount = amount
        self.desc = description
    }
    
    init(category: Category, amount: Double, categoryType: Option) {
        self.category = category
        self.amount = amount
        self.categoryType = categoryType
    }
    
    init(category: Category, amount: Double, description: String, categoryType: Option) {
        self.category = category
        self.amount = amount
        self.desc = description
        self.categoryType = categoryType
    }
}
