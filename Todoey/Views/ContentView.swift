//
//  ContentView.swift
//  Todoey
//
//  Created by Mateo Ortiz on 26/02/23.
//

import SwiftUI

struct ContentView: View {
        
    @StateObject var model = Model()

    @State private var showingAlert = false
    @State private var newItem = ""
    
    let defaults = UserDefaults.standard
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemBlue
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = navBarAppearance
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        
    }
    
    
    
    var body: some View {
        
        NavigationStack {
            List($model.items) { $item in
                RowItem(item: item) {
                    item.completed.toggle()
                }
            }
            .navigationTitle("Todoey")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    showingAlert = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }.alert("Add new Todoey Item", isPresented: $showingAlert) {
                    TextField("Create new item", text: $newItem)
                    Button("Add Item", action: createNewItem)
                }
            }
        }
        
        .onAppear(perform: { loadItems() })
    }
    
    func createNewItem() {
        model.items.append(ToDoItem(title: newItem))
        newItem = ""
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model.items)
            defaults.set(data, forKey: "toDoListArray")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func loadItems() {
                
        if let data = defaults.data(forKey: "toDoListArray") {
            do {
                let decoder = JSONDecoder()

                let decodedItems = try decoder.decode([ToDoItem].self, from: data)

                model.items = decodedItems
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class Model: ObservableObject{
    @Published var items: [ToDoItem] = []
}
