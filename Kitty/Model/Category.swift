//
//  Category.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import Foundation
import Realm
import RealmSwift

//struct CategoryDatabase {
//    var categoryDatabase: [Category]
//}

@objcMembers class Category: Object, Codable  {
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
    
    override init() {
        super.init()
    }

}

struct DummyData {
    let initCategory = [Category(name: "Grocery"), Category(name: "Gifts"), Category(name: "Cafe"), Category(name: "Health"), Category(name: "Commute"), Category(name: "Electronics")]
}
