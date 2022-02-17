//
//  DETimeLogApp.swift
//  Shared
//
//  Created by martinhartl on 15.02.22.
//

import SwiftUI

@main
struct DETimeLogApp: App {
    let entryStore = EntryStore()
    let appStore = AppStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(entryStore)
                .environmentObject(appStore)
            // TODO: Add shortcut for opening file
        }
    }
}
