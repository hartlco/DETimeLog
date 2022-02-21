//
//  SidebarView.swift
//  DETimeLog
//
//  Created by martinhartl on 18.02.22.
//

import SwiftUI
import SwiftUIX

struct SidebarView: View {
    @EnvironmentObject var appStore: AppViewStore
    @EnvironmentObject var entriesViewStore: EntryViewStore

    var body: some View {
        List(selection: appStore.binding(get: \.selectedListType, send: { .setSelectedListType($0) })) {
            Section("Entries") {
                NavigationLink(
                    destination: ContentView(listType: .all)
                ) {
                    Label("All", systemImage: "tray.2")
                }
                .tag(ListType.all)
            }
            Section("Filtered") {
                DisclosureGroup("Days") {
                    ForEach(entriesViewStore.days) { day in
                        NavigationLink(
                            destination: ContentView(listType: .filtered(day: day))
                        ) {
                            Text(day.dateString)
                        }
                        .tag(ListType.filtered(day: day))
                    }
                }
            }
            Section("Categories") {
                NavigationLink(
                    destination: CategoriesView()
                ) {
                    Label("Categories", systemImage: "tag")
                }
                .tag(ListType.categories)
            }
        }
        .listStyle(SidebarListStyle())
    }
}


struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
