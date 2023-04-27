//
//  History.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift

@objcMembers class History: Object  {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var date: Date = Date()
    @Persisted var items: List<Item> = List<Item>()
    
    init(items: List<Item>) {
        self.items = items
    }
    
    init(date: Date, items: [Item]) {
        self.date = date
        let newList = List<Item>()
        for item in items {
            newList.append(item)
        }
        self.items = newList
    }
    
    override init() {
        super.init()
    }
}
