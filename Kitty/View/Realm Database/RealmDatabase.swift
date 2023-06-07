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
    
    func addItem(data: Item) {
        try! realm.write {
            // Add the instance to the realm.
            realm.add(data)
            print("success")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
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
    
    func filterData(categories: [String]) -> [Item] {
        var result:[Item] = []
        
        let array = Array(realm.objects(Item.self))
        
        for category in categories {
            for item in array {
                if item.category == category {
                    result.append(item)
                }
            }
        }
        
        return result
    }
    
    func search(query: String) -> [Item] {
        var result:[Item] = []
        
        let array = Array(realm.objects(Item.self))
        
        for item in array {
            if ((item.desc?.contains(query)) != nil){
                result.append(item)
            }
        }
        
        return result
    }
}
