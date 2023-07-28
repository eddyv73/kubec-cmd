//
//  linuxApp.swift
//  linux
//
//  Created by Eddy Wister on 03/07/23.
//

import SwiftUI

@main
struct linuxApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
