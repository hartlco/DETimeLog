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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(entryStore)
        }
    }
}
