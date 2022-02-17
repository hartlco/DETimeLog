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
    @EnvironmentObject var appStore: AppStore

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(entryStore.entries) { entry in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(entry.category)
                                    .font(.body)
                                Text(entry.title)
                                    .font(.caption)
                            }
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
        .fileImporter(
            isPresented: appStore.isOpeningFile,
            allowedContentTypes: [.plainText],
            allowsMultipleSelection: false
        ) { result in
            do {
                // TODO: Reopen last opened file
                guard let selectedFile: URL = try result.get().first else { return }
                entryStore.reduce(.load(fileURL: selectedFile))
            } catch {
                print("Unable to read file contents")
                print(error.localizedDescription)
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    appStore.reduce(.showFileOpener)
                } label: {
                    Label("Open", systemImage: "folder.badge.plus")
                }

            }
        }
    }
}

// TODO: Add preview mock data
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
