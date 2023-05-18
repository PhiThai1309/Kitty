//
//  RealmDatabase.swift
//  Kitty
//
//  Created by phi.thai on 5/18/23.
//

import Foundation
import RealmSwift

class RealmDatabase {
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func loadItem() -> [Item] {
        realm.refresh()
        // Access all dogs in the realm
        return Array(realm.objects(Item.self))
    }
    
    func loadHistoryWithMonth(items: [Item]) -> [History]{
        var result : [History] = []
        for item in items {
            if result.firstIndex(where: {$0.date.month == item.date.month}) != nil {
                let i = result.firstIndex(where: {$0.date.month == item.date.month})!
                result[i].items.append(item)
            } else {
                let newItem: [Item] = [item]
                let newHistory = History(date: item.date, items: newItem)
                result.append(newHistory)
            }
        }
        return result
    }
}
