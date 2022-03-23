//
//  AddEntryStore.swift
//  DETimeLog
//
//  Created by martinhartl on 17.03.22.
//

import Foundation
import ViewStore

struct AddEntryState {
    var availableCategories: [Category]
    var selectedCategory: Category?
    var title: String?
    var description: String?
    var dateTime: Date = Date()
}

enum AddEntryAction {
    case selectCategory(Category?)
    case setTitle(String?)
    case setDescription(String?)
    case setDateTime(Date)
    case addEntry
}

let addEntryReducer: ReduceFunction<AddEntryState, AddEntryAction, EntryEnvironment> = { state, action, env in
    switch action {
    case let .selectCategory(category):
        state.selectedCategory = category
    case let .setTitle(title):
        state.title = title
    case let .setDescription(description):
        state.description = description
    case let .setDateTime(dateTime):
        state.dateTime = dateTime
    case .addEntry:
        break
    }

    return .none
}

typealias AddEntryStore = ViewStore<AddEntryState, AddEntryAction, EntryEnvironment>


extension AddEntryStore {
#if DEBUG
    static let mock = AddEntryStore(
        state: AddEntryState(
            availableCategories: [
                Category(title: "Productivity")
            ]
        ),
        environment: .init(
            fileParser: FileParser(),
            colorStore: ColorStore(userDefaults: .standard)
        ),
        reduceFunction: addEntryReducer
    )
#endif
}
