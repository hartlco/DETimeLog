//
//  EntriesListView.swift
//  DETimeLog
//
//  Created by martinhartl on 28.02.22.
//

import SwiftUI

struct EntriesListView: View {
    @EnvironmentObject var entryStore: EntryViewStore

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
    }
}
