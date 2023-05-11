//
//  Item.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift
import Realm

enum Option: String, PersistableEnum {
    case Expenses
    case Income
}

class Item: Object {
    @Persisted(primaryKey: true) var id = "h1"
    @Persisted var category: Category? = Category(name: "")
    @Persisted var amount: Double = 0.0
    @Persisted var desc: String?
    @Persisted var categoryType: Option = Option.Expenses
    
    init(category: Category, amount: Double, categoryType: Option) {
        self.id = "i" + String(Int.random(in: 1..<500))
        self.category = category
        self.amount = amount
        self.categoryType = categoryType
    }
    
    init(category: Category, amount: Double, description: String, categoryType: Option) {
        self.id = "i" + String(Int.random(in: 1..<500))
        self.category = category
        self.amount = amount
        self.desc = description
        self.categoryType = categoryType
    }
    override init() {
        super.init()
    }
}
