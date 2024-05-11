//
//  DemoDevoteApp.swift
//  DemoDevote
//
//  Created by Aguid Ramirez Sanchez on 18/04/24.
//

import SwiftUI

@main
struct DemoDevoteApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
