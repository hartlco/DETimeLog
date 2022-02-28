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
        HSplitView {
            EntriesListView(
                listType: listType
            )
            if appStore.isShowingListDetail {
                EntriesListDetailsView()
                    .frame(maxHeight: .infinity)
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
            ToolbarItem {
                Button {
                    appStore.send(.setShowListDetail(!appStore.isShowingListDetail))
                } label: {
                    Label("Show Edit Link", systemImage: "sidebar.right")
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
