//
//  RealmDatabase.swift
//  Kitty
//
//  Created by phi.thai on 5/18/23.
//

import Foundation
import RealmSwift
import FirebaseAuth

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class RealmDatabase {
    let realm: Realm
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    init() {
        self.realm = try! Realm()
    }
    
    func loadItem() -> [Item] {
        realm.refresh()
        
        let array = Array(realm.objects(Item.self))
        var result: [Item] = []
        
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
    
    func loadItemFireStore(completionHandler: @escaping ([Item]) -> Void){
        var result: [Item] = []
        db.collection(user!.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    let user = data["user"] as? String ?? ""
                    let amount = data["amount"] as? Double ?? 0.0
                    let category = data["category"] as? String ?? "Commute"
                    let date = data["date"] as? Date ?? Date.now
                    var categoryType = data["categoryType"]
                    if categoryType as! String == "Expenses" {
                        categoryType = Option.Expenses
                    } else {
                        categoryType = Option.Income
                    }
                    let desc = data["desc"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    
                    let newItem = Item(id: id, user: user, category: category, amount: amount, categoryType: categoryType as! Option, desc: desc)
                    result.append(newItem)
                    
                }
            }
            completionHandler(result)
        }
//        completionHandler(result)
//        return result
    }
    
    func addItem(data: Item) {
        try! realm.write {
            // Add the instance to the realm.
            realm.add(data)
            print("success")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func addItemFireStore(data: Item) {
        do {
            try db.collection(user!.uid).document().setData(from: data)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
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
