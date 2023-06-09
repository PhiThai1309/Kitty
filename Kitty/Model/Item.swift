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
import FirebaseCore
import Firebase

enum Option: String, PersistableEnum, Codable {
    case Expenses
    case Income
}

class Item: Object, Codable {
    @Persisted(primaryKey: true) var id = "h1"
    @Persisted var user: String
    @Persisted var date: Date
    var timeStamp: Timestamp?
    @Persisted var category: String
    @Persisted var amount: Double
    @Persisted var desc: String?
    @Persisted var categoryType: Option
    
    init(id: String, user: String, category: String, amount: Double, categoryType: Option, desc: String, date: Date) {
        self.id = id
        self.user = user
        self.date = Date()
        self.category = category
        self.amount = amount
        self.categoryType = categoryType
        self.desc = desc
        self.date = date
    }
    
    init(id: String, user: String, category: String, amount: Double, categoryType: Option, desc: String, date: Timestamp) {
        self.id = id
        self.user = user
        self.date = Date()
        self.category = category
        self.amount = amount
        self.categoryType = categoryType
        self.desc = desc
        self.timeStamp = date
    }
    
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
    case timeStamp
}
