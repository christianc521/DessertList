//
//  RecipeFinderApp.swift
//  RecipeFinder
//
//  Created by Christian Cruz on 12/7/23.
//

import SwiftUI

@main
struct RecipeFinderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
