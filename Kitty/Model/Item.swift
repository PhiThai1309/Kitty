//
//  Item.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift
import Realm

enum Option: String, PersistableEnum, Codable {
    case Expenses
    case Income
}

class Item:Codable {
//    @Persisted(primaryKey: true) var id = "h1"
    var date: Date
    var category: Category? = Category(name: "")
    var amount: Double = 0.0
    var desc: String?
    var categoryType: Option = Option.Expenses
    
    init(category: Category, amount: Double, categoryType: Option) {
//        self.id = "i" + String(Int.random(in: 1..<500))
        self.date = Date()
        self.category = category
        self.amount = amount
        self.categoryType = categoryType
    }
    
    init(category: Category, amount: Double, description: String, categoryType: Option) {
//        self.id = "i" + String(Int.random(in: 1..<500))
        self.date = Date()
        self.category = category
        self.amount = amount
        self.desc = description
        self.categoryType = categoryType
    }
//    override init() {
//        super.init()
//    }
}
