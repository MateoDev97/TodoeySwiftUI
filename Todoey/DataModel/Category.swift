//
//  Category.swift
//  Todoey
//
//  Created by Brian Ortiz on 2023-05-25.
//

import Foundation
import RealmSwift

class Category: Object, Identifiable {
    let id = UUID()
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
