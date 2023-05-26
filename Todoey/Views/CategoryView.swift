//
//  ContentView.swift
//  Todoey
//
//  Created by Mateo Ortiz on 26/02/23.
//

import SwiftUI

struct CategoryView: View {
        
    @StateObject var viewModel = CategoryViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                if let categories = viewModel.categories, !categories.isEmpty {
                    ForEach(categories) { category in
                        NavigationLink(destination: ItemsView(category: category)) {
                            VStack {
                                Text(category.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                            }
                        }.buttonStyle(.plain)
                    }
                    
                } else {
                    Text("No categories added yet")
                }
                Spacer()
            }
            .padding(.horizontal, 25)
            .padding(.top, 30)
            
            .navigationTitle("Todoey")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    viewModel.showingAlert = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }.alert("Add new Category", isPresented: $viewModel.showingAlert) {
                    TextField("Add a new category", text: $viewModel.newCategoryName)
                    Button("Add", action: viewModel.createNewCategory)
                }
            }
            
        }
        
        .onAppear(perform: { viewModel.loadCategories() })
    }
    
    
    
}
