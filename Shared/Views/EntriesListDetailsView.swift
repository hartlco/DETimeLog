//
//  EntriesListDetailsView.swift
//  DETimeLog
//
//  Created by martinhartl on 28.02.22.
//

import SwiftUI

struct EntriesListDetailsView: View {
    @EnvironmentObject var entryStore: EntryViewStore

    let listType: ListType

    var body: some View {
        List {
            ForEach(entryStore.categoryDurations(for: listType)) { categoryDuration in
                HStack {
                    Text(categoryDuration.category.title)
                    Text(categoryDuration.formattedDuration)
                }
            }
        }
    }
}

struct EntriesListDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesListDetailsView(listType: .all)
    }
}
