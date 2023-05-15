//
//  History.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift
import Realm

class History:  Codable  {
//    @Persisted(primaryKey: true) var id = "h1"
//    var date: Date
    
    var items: [Item] = [Item]()
    
    init(items: [Item]) {
//        self.id = "h" + String(Int.random(in: 1..<500))
//        self.date = Date()
        self.items = items
    }
    
    init(date: Date, items: [Item]) {
//        self.id = "h" + String(Int.random(in: 1..<500))
//        self.date = date
//        let newList = RealmSwift.List<Item>()
        self.items = items
    }

    
    enum CodingKeys: String, CodingKey {
//        case date
        case items
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        date = try values.decode(Date.self, forKey: .date)
        items = try values.decode([Item].self, forKey: .items)
    }
}

