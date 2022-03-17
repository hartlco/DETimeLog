//
//  AddEntryView.swift
//  DETimeLog
//
//  Created by martinhartl on 17.03.22.
//

import SwiftUI

struct AddEntryView: View {
    @EnvironmentObject var addEntryStore: AddEntryStore

    var body: some View {
        Form {
            Picker(
                "Category",
                selection: addEntryStore.binding(get: \.selectedCategory, send: { .selectCategory($0) })
            ) {
                ForEach(addEntryStore.availableCategories) { category in
                    Text(category.title).tag(category)
                }
            }
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
            .environmentObject(AddEntryStore.mock)
    }
}
