//
//  Item.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift
import Realm
import FirebaseFirestoreSwift

enum Option: String, PersistableEnum, Codable {
    case Expenses
    case Income
}

class Item: Object, Codable {
    @Persisted(primaryKey: true) var id = "h1"
//    @DocumentID var id = "h1"
    @Persisted var user: String
    @Persisted var date: Date
    @Persisted var category: String
    @Persisted var amount: Double
    @Persisted var desc: String?
    @Persisted var categoryType: Option
    
    init(user: String, category: String, amount: Double, categoryType: Option) {
        self.id = "i" + String(Int.random(in: 1..<500))
        self.user = user
        self.date = Date()
        self.category = category
        self.amount = amount
        self.categoryType = categoryType
    }
    
    init(user: String, category: String, amount: Double, description: String, categoryType: Option) {
        self.id = "i" + String(Int.random(in: 1..<500))
        self.user = user
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

enum CodingKeys: String, CodingKey  {
    case id
    case user
    case date
    case category
    case amount
    case desc
    case categoryType
}


//struct DummyItem {
//    var items = [Item]()
//    
//    init() {
//        let item1 = Item(category: "Grocery", amount: 120.0, description: "Example description", categoryType: Option.Expenses)
//        let item2 = Item(category: "Gifts", amount: 22.0, description: "Example description2", categoryType: Option.Expenses)
//        let item3 = Item(category: "Gifts", amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
//        let item4 = Item(category: "Electronics", amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
//        items.append(item1)
//        items.append(item2)
//        items.append(item3)
//        items.append(item4)
//    }
//}
