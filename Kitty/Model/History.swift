//
//  History.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift
import Realm

class History: Object  {
    @Persisted(primaryKey: true) var id = "h1"
    @Persisted var date: Date = Date()
    
    var items: RealmSwift.List<Item> = RealmSwift.List<Item>()
    
    init(items: RealmSwift.List<Item>) {
        self.id = "h" + String(Int.random(in: 1..<500))
        self.items = items
    }
    
    init(date: Date, items: [Item]) {
        self.id = "h" + String(Int.random(in: 1..<500))
        self.date = date
        let newList = RealmSwift.List<Item>()
        for item in items {
//            newList.append(item)
        }
        self.items = newList
    }
    
    override init() {
        super.init()
    }
}
