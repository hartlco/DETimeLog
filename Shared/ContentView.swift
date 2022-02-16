//
//  ContentView.swift
//  Shared
//
//  Created by martinhartl on 15.02.22.
//

import SwiftUI

extension Color {
    static func color(for category: String) -> Color {
        switch category {
        case "bad":
            return Color.blue
        case "essen":
            return Color.green
        case "social media":
            return Color.red
        case "arbeit":
            return Color.orange
        case "schlafen":
            return .gray
        default:
            return .clear
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var entryStore: EntryStore

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(entryStore.entries) { entry in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(entry.category)
                            Text(entry.formattedDuration)
                        }
                        Spacer()
                    }
                    .frame(
                        height: 20 + CGFloat(entry.minutes)
                    )
                    .background(Color.color(for: entry.category))
                    .padding()
                }
            }
        }
        .task {
            entryStore.reduce(.load)
        }
    }
}

// TODO: Add preview mock data
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
