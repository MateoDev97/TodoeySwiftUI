//
//  RowItem.swift
//  Todoey
//
//  Created by Mateo Ortiz on 26/02/23.
//

import SwiftUI

struct RowItem: View {
    let item: ToDoItem
    let onTap: (() -> Void)?

    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
            Image(systemName: item.completed ? "checkmark.square.fill" :  "squareshape" )
                .foregroundColor(item.completed ? .blue : .clear)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}

struct RowItem_Previews: PreviewProvider {
    static var previews: some View {
        RowItem(item: ToDoItem(title: "Buy Eggs"), onTap: {})
    }
}
