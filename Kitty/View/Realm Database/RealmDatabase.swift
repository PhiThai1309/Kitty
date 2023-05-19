//
//  RealmDatabase.swift
//  Kitty
//
//  Created by phi.thai on 5/18/23.
//

import Foundation
import RealmSwift
import FirebaseAuth

class RealmDatabase {
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func loadItem() -> [Item] {
        realm.refresh()
        // Access all dogs in the realm
        let array = Array(realm.objects(Item.self))
        var result: [Item] = []
        
        let user = Auth.auth().currentUser
        
        for item in array {
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                if item.user == uid {
                    result.append(item)
                }
            }
        }
        return result
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
