//
//  LogStore.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

import Foundation
import SwiftUI
import ViewStore

typealias EntryViewStore = ViewStore<EntryState, EntryAction, EntryEnvironment>

enum ListType: Hashable, Equatable {
    case all
    case categories
}

struct EntryState {
    var entries: [Entry] = []
    var categories: [Category] = []
    var colorsByCategory: [Category: CGColor] = [:]
}

enum EntryAction {
    case load(fileURL: URL)
    case categoryColorAction(Category, CategoryColorAction)
}

struct EntryEnvironment {
    let fileParser: FileParser
    let colorStore: ColorStore
}

let entryReducer: ReduceFunction<EntryState, EntryAction, EntryEnvironment> = { state, action, environment in
    switch action {
    case let .load(fileURL):
        do {
            let parseResult = try await environment.fileParser.parse(fileURL: fileURL)
            state.entries = parseResult.entries
            state.categories = parseResult.categories
            state.colorsByCategory = environment.colorStore.colors(for: parseResult.categories)
        } catch {
            // TODO: Error handling
        }
    case let .categoryColorAction(category, action):
        switch action {
        case let .changeColor(color):
            environment.colorStore.set(color: color, for: category)
            state.colorsByCategory[category] = color
        }
    }
}
