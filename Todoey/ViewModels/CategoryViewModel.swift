//
//  CategoryViewModel.swift
//  Todoey
//
//  Created by Brian Ortiz on 2023-05-25.
//

import Foundation
import SwiftUI
import RealmSwift

class CategoryViewModel: ObservableObject {
    
    @Published var categories: Results<Category>?
    
    @Published var showingAlert = false
    @Published var newCategoryName = ""
    
    let realm = try! Realm()
    
    func createNewCategory() {
        
        if newCategoryName.isEmpty {
            return
        }
        
        let newCategory = Category()
        
        newCategory.name = newCategoryName
        
        do {
            try realm.write {
                realm.add(newCategory)
            }
        } catch {
            print("Error saving category")
        }
        
    }
    
    func loadCategories() {
                
        categories = realm.objects(Category.self)
    }
}
