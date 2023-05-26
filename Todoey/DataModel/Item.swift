//
//  Item.swift
//  Todoey
//
//  Created by Brian Ortiz on 2023-05-25.
//

import Foundation
import RealmSwift

class Item: Object, Identifiable {
    let id = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
