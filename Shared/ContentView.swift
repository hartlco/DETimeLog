//
//  ContentView.swift
//  Shared
//
//  Created by martinhartl on 15.02.22.
//

import SwiftUI

extension Color {
    static func color(for category: Category) -> Color {
        switch category.title {
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
    @EnvironmentObject var entryStore: EntryViewStore
    @EnvironmentObject var appStore: AppViewStore

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(entryStore.entries) { entry in
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(entry.category.title)
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
                        .padding()
                        .background(Color.color(for: entry.category))
                    }
                    Text(entry.date.formatted())
                }
            }
        }
        .fileImporter(
            isPresented: appStore.isOpeningFileBinding,
            allowedContentTypes: [.plainText],
            allowsMultipleSelection: false
        ) { result in
            do {
                // TODO: Reopen last opened file
                guard let selectedFile: URL = try result.get().first else { return }
                entryStore.send(.load(fileURL: selectedFile))
            } catch {
                print("Unable to read file contents")
                print(error.localizedDescription)
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    appStore.send(.showFileOpener)
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
