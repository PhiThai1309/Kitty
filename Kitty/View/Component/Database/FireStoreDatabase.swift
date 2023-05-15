//
//  FireStoreDatabase.swift
//  Kitty
//
//  Created by phi.thai on 5/12/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class FireStoreDatabase {
    private var dummyData = DummyData()
    private var items: [Item] = []
    private var history: [History] = []
    
    let db = Firestore.firestore()
    
    func getCurrentUser() -> String {
        let userInfo = Auth.auth().currentUser
        // Provider-specific UID
        let userID = userInfo!.uid
        return userID
    }
    
    func saveDummyDatabase() {
        let item1 = Item(category: dummyData.initCategory[1], amount: 120.0, description: "Example description", categoryType: Option.Expenses)
        let item2 = Item(category: dummyData.initCategory[3], amount: 22.0, description: "Example description2", categoryType: Option.Expenses)
        let item3 = Item(category: dummyData.initCategory[3], amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        let item4 = Item(category: dummyData.initCategory[4], amount: 32.0, description: "Example description3", categoryType: Option.Expenses)
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        
        let components = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 4)
        let date = NSCalendar.current.date(from: components)
        
        let components2 = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 6)
        let date2 = NSCalendar.current.date(from: components2)
        
        let components3 = DateComponents (calendar: Calendar.current, year: 2023, month: 3, day: 1)
        let date3 = NSCalendar.current.date(from: components3)
        
        let history1 = History(date: date!, items: [item1, item3])
        let history2 = History(date: date2!, items: [item2])
        let history3 = History(date: date3!, items: [item4])
        
        history.append(history1)
        history.append(history2)
        history.append(history3)
        
        do {
            let dtFormatter = DateFormatter()
            dtFormatter.dateFormat = "d MMMM YYYY"
            dtFormatter.locale = Locale(identifier: "en_US")
            //            print(dtFormatter.string(from: history1.date))
            let userID = getCurrentUser()
            try db.collection(userID).document("item1").setData(from: item1)
            try db.collection(userID).document("item2").setData(from: item2)
            try db.collection(userID).document("item3").setData(from: item3)
            try db.collection(userID).document("history").setData(from: history1)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func saveData() {
        
    }
    
    func loadItemsData() -> [Item] {
        var result: [Item] = []
        let userID = getCurrentUser()
        db.collection(userID).getDocuments() { (querySnapshot, erorr) in
            for document in querySnapshot!.documents {
                if document.documentID.contains("item") {
                    var date: Date
                    var category: Category?
                    var amount: Double = 0.0
                    var desc: String?
                    var categoryType: Option = Option.Expenses
                    
                    for data in document.data() {
                        if data.key == "amount" {
                            amount = data.value as! Double
                        } else if data.key == "desc" {
                            desc = data.value as? String
                        } else if data.key == "categoryType" {
                            if data.value as! String == "Expenses" {
                                categoryType = Option.Expenses
                            } else {
                                categoryType = Option.Income
                            }
                        } else if data.key == "category" {
                            do {
                                let json = try JSONSerialization.data(withJSONObject: data.value)
                                let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                let decodedCountries = try decoder.decode(Category.self, from: json)
                                category = decodedCountries
                            } catch {}
                        }
                    }
                    let newItem = Item(category: category!, amount: amount, description: desc!, categoryType: categoryType)
                    result.append(newItem)
                    print(result)
                }
            }
        }
        DispatchQueue.main.async {
            print(result)
        }
        return result
    }
    
    
    
//    func loadHistoryData() -> [History]{
//        var history: [History] = []
//        let userID = getCurrentUser()
//        db.collection(userID).getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
////                                        print("12312312 12312312 \(document.data())")
//                    //                    guard let data = document.data else { return }
//                    //                    print(data)
//                    do {
//                        //                        let data = try JSONSerialization.data(withJSONObject: document.data())
//                        //                        print(data)
////                        let decoder = JSONDecoder()
////                        decoder.keyDecodingStrategy = .convertFromSnakeCase
////                        let historyItem = try decoder.decode([Item].self, from: document.data()[0])
//                        let newItem = Item(category: document.data()["category"] as! Category, amount: document.data()["amount"] as! Double, description: document.data() as! String, categoryType: document.data() as! Option)
//                        print(newItem)
////                        let newHistory = document.data()["items"] as! [Any]
//
////                        print(newHistory)
//                        //                        history.append(historyItem)
//                    } catch {}
//                }
//            }
//        }
//        print(history)
//        return history
//    }
}
