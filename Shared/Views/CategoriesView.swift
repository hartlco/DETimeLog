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
            CategoryView()
                .environmentObject(
                    entryStore.scope(
                        state: { state in
                            return CategoryColorState(
                                category: category,
                                color: entryStore.colorsByCategory[category] ?? CGColor.init(gray: 0.3, alpha: 1.0)
                            )
                        }, action: { action in
                            return .categoryColorAction(category, action)
                        }, scopedReducer: categoryColorReducer
                    )
                )
        }
        .fileImporter(
            isPresented: appStore.binding(get: \.isOpeningFile, send: { .isShowingFileOpener($0) }),
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

struct CategoryView: View {
    @EnvironmentObject var categoryColorViewStore: CategoryColorViewStore

    @State var pickedColor = SwiftUI.Color.green

    var body: some View {
        HStack {
            Text(categoryColorViewStore.category.title)
            Spacer()
            ColorPicker(
                "Color",
                selection: categoryColorViewStore.binding(get: \.color, send: { .changeColor(color: $0 ) })
            )
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
