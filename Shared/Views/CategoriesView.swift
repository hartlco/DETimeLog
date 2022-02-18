//
//  CategoriesView.swift
//  DETimeLog
//
//  Created by martinhartl on 18.02.22.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var appStore: AppViewStore
    @EnvironmentObject var entryStore: EntryViewStore

    var body: some View {
        List(entryStore.categories) { category in
            Text(category.title)
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

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
