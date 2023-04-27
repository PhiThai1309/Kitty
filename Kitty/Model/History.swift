//
//  History.swift
//  Kitty
//
//  Created by phi.thai on 4/17/23.
//

import Foundation
import RealmSwift

@objcMembers class History: Object  {
    var date: Date = Date()
    var items: [Item] = []
    
    init(items: [Item]) {
        self.items = items
    }
    
    init(date: Date, items: [Item]) {
        self.date = date
        self.items = items
    }
    
    override init() {
        super.init()
    }
}
