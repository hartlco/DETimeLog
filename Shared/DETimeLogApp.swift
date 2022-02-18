//
//  DETimeLogApp.swift
//  Shared
//
//  Created by martinhartl on 15.02.22.
//

import SwiftUI

@main
struct DETimeLogApp: App {
    let entryStore = EntryViewStore(
        state: EntryState(),
        environment: EntryEnvironment(fileParser: FileParser()),
        reduceFunction: entryReducer
    )
    let appStore = AppViewStore(
        state: AppState(),
        environment: AppEnvironment(),
        reduceFunction: appReducer
    )

    var body: some Scene {
        WindowGroup {
            NavigationView {
                InitialContentView()
            }
            .environmentObject(entryStore)
            .environmentObject(appStore)
            // TODO: Add shortcut for opening file
        }
    }
}
