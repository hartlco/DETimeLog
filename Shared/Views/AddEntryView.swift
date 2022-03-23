//
//  AddEntryView.swift
//  DETimeLog
//
//  Created by martinhartl on 17.03.22.
//

import SwiftUI

struct AddEntryView: View {
    @EnvironmentObject var addEntryStore: AddEntryStore

    @State var selection: Category?

    var body: some View {
        print(Self._printChanges())
        return Form {
            Picker(
                "Category",
                selection: addEntryStore.binding(get: \.selectedCategory, send: { .selectCategory($0) })
            ) {
                ForEach(addEntryStore.availableCategories) { category in
                    Text(category.title).tag(category as Category?)
                }
            }
            TextField(
                "Title",
                text: addEntryStore.binding(get: \.title, send: { .setTitle($0) })
            )
            TextField(
                "Description",
                text: addEntryStore.binding(get: \.description, send: { .setDescription($0) })
            )
            DatePicker(
                "Date",
                selection: addEntryStore.binding(get: \.dateTime, send: { .setDateTime($0) })
            )
            HStack {
                Spacer()
                Button {
                    addEntryStore.send(.addEntry)
                } label: {
                    Text("Add")
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
