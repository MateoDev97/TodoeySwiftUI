//
//  ItemViewModel.swift
//  Todoey
//
//  Created by Brian Ortiz on 2023-05-25.
//


import Foundation
import SwiftUI
import RealmSwift

class ItemViewModel: ObservableObject {
    
    @Published var textSearch = ""

    @Published var items: Results<Item>?
        
    @Published var showingAlert = false
    @Published var newItemName = ""
    
    let realm = try! Realm()
    
    private var category: Category?
    
    func setUpViewModel(_ category: Category) {
        self.category = category
        loadItems()
    }
    
    func createNewItem() {
        if newItemName.isEmpty {
            return
        }
        
        let newItem = Item()
        
        newItem.title = newItemName
        
        do {
            try realm.write {
                if let category = self.category {
                    category.items.append(newItem)
                }
            }
        } catch {
            print("Error saving item")
        }
        
    }
    
    func loadItems() {
        
        if let category = self.category {
            items = category.items.sorted(byKeyPath: "title", ascending: true)
        }
        
    }
    
    func updateItemCheck(index: Int) {
        
        do {
            try realm.write {
                
                if let items = self.items {
                    items[index].done = !items[index].done
                }
                
            }
        } catch {
            print("Error updating item")
        }
        
        loadItems()
    }
    
    func filterResults(text: String) {
        
        
        if text.isEmpty {
            loadItems()
        } else {
            items = items?.filter("title CONTAINS[cd] %@", text).sorted(byKeyPath: "title", ascending: true)
        }
        
    }
}
