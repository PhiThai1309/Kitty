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

class Category: Object, Codable  {
    @Persisted(primaryKey: true) var id = "c1"
    @Persisted var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
        
    }
    
    override init() {
        super.init()
    }

}

struct DummyData {
    let initCategory = [Category(name: "Grocery"), Category(name: "Gifts"), Category(name: "Cafe"), Category(name: "Health"), Category(name: "Commute"), Category(name: "Electronics")]
}
