//
//  LogStore.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

import Foundation
import SwiftUI

typealias EntryViewStore = ViewStore<EntryState, EntryAction, EntryEnvironment>

enum ListType: Hashable, Equatable {
    case all
    case categories
}

struct EntryState {
    var entries: [Entry] = []
    var categories: [Category] = []
}

enum EntryAction {
    case load(fileURL: URL)
}

struct EntryEnvironment {
    let fileParser: FileParser
}

let entryReducer: ReduceFunction<EntryState, EntryAction, EntryEnvironment> = { state, action, environment in
    switch action {
    case let .load(fileURL):
        do {
            let parseResult = try await environment.fileParser.parse(fileURL: fileURL)
            state.entries = parseResult.entries
            state.categories = parseResult.categories
        } catch {
            // TODO: Error handling
        }
    }
}
