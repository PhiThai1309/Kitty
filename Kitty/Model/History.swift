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
    
    convenience init(date: Date, items: Item) {
        self.init()
        self.id = "h" + String(Int.random(in: 1..<500))
        self.date = date
//        addRealm(items: items)
        self.items.append(items)
        
    }
    
    override init() {
        super.init()
    }
    
    func addRealm(items: Item) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(items)
            
        }
    }
}
