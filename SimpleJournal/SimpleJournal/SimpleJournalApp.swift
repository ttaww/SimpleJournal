//
//  SimpleJournalApp.swift
//  SimpleJournal
//
//  Created by Tingting on 2022-03-06.
//

import SwiftUI

@main
struct SimpleJournalApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
