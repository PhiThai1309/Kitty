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
    @Persisted var date: Date
    @Persisted var category: String
    @Persisted var amount: Double
    @Persisted var desc: String?
    @Persisted var categoryType: Option
    
    init(category: String, amount: Double, categoryType: Option) {
        self.id = "i" + String(Int.random(in: 1..<500))
        self.date = Date()
        self.category = category
        self.amount = amount
        self.categoryType = categoryType
    }
    
    init(category: String, amount: Double, description: String, categoryType: Option) {
        self.id = "i" + String(Int.random(in: 1..<500))
        self.date = Date()
        self.category = category
        self.amount = amount
        self.desc = description
        self.categoryType = categoryType
    }
    override init() {
        super.init()
    }
}

struct DummyItem {
    var items = [Item]()
    
    init() {
        let item1 = Item(category: "Grocery", amount: 120.0, description: "Example description", categoryType: Option.Expenses)
        let item2 = Item(category: "Gifts", amount: 22.0, description: "Example description2", categoryType: Option.Expenses)
        let item3 = Item(category: "Gifts", amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        let item4 = Item(category: "Electronics", amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
    }
}
