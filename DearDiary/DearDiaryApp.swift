//
//  DearDiaryApp.swift
//  DearDiary
//
//  Created by eman alejilah on 15/06/1444 AH.
//

import SwiftUI

@main
struct DearDiaryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
