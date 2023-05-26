//
//  TodoeyApp.swift
//  Todoey
//
//  Created by Mateo Ortiz on 26/02/23.
//

import SwiftUI
import RealmSwift


@main
struct TodoeyApp: SwiftUI.App {
    
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
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            CategoryView()
        }
    }
}
