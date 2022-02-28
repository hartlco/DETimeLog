//
//  CategoryColorViewStore.swift
//  DETimeLog
//
//  Created by martinhartl on 19.02.22.
//

#if os(iOS)
import UIKit
#endif

import Foundation
import ViewStore

struct CategoryColorState {
    var category: Category
    var color: CGColor
}

enum CategoryColorAction {
    case changeColor(color: CGColor)
}

let categoryColorReducer: ReduceFunction<CategoryColorState, CategoryColorAction, EntryEnvironment> = { state, action, env in
    switch action {
    case let .changeColor(color):
        state.color = color
    }

    return .none
}

typealias CategoryColorViewStore = ViewStore<CategoryColorState, CategoryColorAction, EntryEnvironment>
