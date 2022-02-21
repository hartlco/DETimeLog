//
//  ContentView.swift
//  Shared
//
//  Created by martinhartl on 15.02.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var entryStore: EntryViewStore
    @EnvironmentObject var appStore: AppViewStore

    let listType: ListType

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(entryStore.entries(for: listType)) { entry in
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
                        .background(.ultraThinMaterial)
                        .background(
                            SwiftUI.Color(
                                cgColor: entryStore.colorsByCategory[entry.category] ?? CGColor(gray: 0.2, alpha:1.0)
                            )
                        )
                    }
                    Text(entry.date.formatted())
                }
            }
        }
        .fileImporter(
            isPresented: appStore.binding(get: \.isOpeningFile, send: { .isShowingFileOpener($0) }),
            allowedContentTypes: [.plainText],
            allowsMultipleSelection: false
        ) { result in
            do {
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
        ContentView(listType: .all)
    }
}
