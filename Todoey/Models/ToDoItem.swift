//
//  ToDoItem.swift
//  Todoey
//
//  Created by Mateo Ortiz on 26/02/23.
//

import Foundation

struct ToDoItem: Hashable, Identifiable, Codable {
    var id = UUID()
    var title: String
    var completed: Bool = false

    init(title: String) {
        self.title = title
    }
}
