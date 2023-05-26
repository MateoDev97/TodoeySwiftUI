//
//  ItemsView.swift
//  Todoey
//
//  Created by Brian Ortiz on 2023-05-25.
//

import SwiftUI

struct ItemsView: View {
    
    var category: Category
    @ObservedObject var viewModel = ItemViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            
            TextField("Search for item", text: $viewModel.textSearch)
                .autocorrectionDisabled()
                .frame(height: 40)
                .background(Color(.systemGray6))
                .padding(.bottom, 15)
                .onChange(of: viewModel.textSearch) {
                    viewModel.filterResults(text: $0)
                }
            if let items = viewModel.items, !items.isEmpty {
                ForEach(0..<items.count, id: \.self) { index in
                    
                    HStack {
                        Text(items[index].title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: items[index].done ? "checkmark.square.fill" :  "square")
                            .foregroundColor(items[index].done ? .blue : .gray)
                    }.onTapGesture {
                        viewModel.updateItemCheck(index: index)
                    }
                    Divider()
                        
                }
                
            } else {
                Text("No items found for category \(category.name)")
            }
            Spacer()
        }.onAppear(perform: { viewModel.setUpViewModel(category) })
        
        .padding(.horizontal, 25)
        .padding(.top, 30)
        
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Todoey")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showingAlert = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }.alert("Add new Item", isPresented: $viewModel.showingAlert) {
                    TextField("Add a new Item", text: $viewModel.newItemName)
                    Button("Add", action: viewModel.createNewItem)
                }
            }
            
            
        }
    }
}
