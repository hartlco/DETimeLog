//
//  SidebarView.swift
//  DETimeLog
//
//  Created by martinhartl on 18.02.22.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var appStore: AppStore

    var body: some View {
        List(selection: appStore.selectedListType) {
            Section("Header") {
                NavigationLink(
                    destination: ContentView(),
                    tag: ListType.all,
                    selection: appStore.selectedListType
                ) {
                    Label("All", systemImage: "tray.2")
                }
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
