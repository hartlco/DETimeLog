//
//  ContentView.swift
//  Shared
//
//  Created by martinhartl on 15.02.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var entryStore: EntryStore

    var body: some View {
        List(entryStore.entries) { entry in
            VStack(alignment: .leading) {
                Text(entry.category)
                Text(entry.formattedDuration)
            }
        }
        .task {
            entryStore.reduce(.load)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
