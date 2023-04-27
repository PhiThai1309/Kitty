//
//  Category.swift
//  Kitty
//
//  Created by phi.thai on 4/20/23.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Category: Object  {
    var name: String = "Expenses"
    
    init(name: String) {
        self.name = name
    }
    
    override init() {
        super.init()
    }

}
