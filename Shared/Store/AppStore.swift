//
//  AppStore.swift
//  DETimeLog
//
//  Created by martinhartl on 17.02.22.
//

import Foundation
import SwiftUI
import ViewStore

typealias AppViewStore = ViewStore<AppState, AppAction, AppEnvironment>

#if DEBUG
extension AppViewStore {
    static let mock = AppViewStore(state: .init(), environment: .init(), reduceFunction: appReducer)
}

#endif

struct AppState {
    var selectedListType: ListType? = .all
    var selectedCategory: Category?
    var isOpeningFile = false
    var isShowingListDetail = true
    var isShowingAddView = false
}

enum AppAction {
    case showFileOpener
    case isShowingFileOpener(Bool)
    case setSelectedListType(ListType?)
    case setSelectedCategory(Category?)
    case setShowListDetail(Bool)
    case setIsShowingAddView(Bool)
    case showAddView
}

struct AppEnvironment {
    let userDefaults: UserDefaults = .standard
}

let appReducer: ReduceFunction<AppState, AppAction, AppEnvironment> = { state, action, env in
    switch action {
    case .showFileOpener:
        state.isOpeningFile = true
    case let .isShowingFileOpener(value):
        state.isOpeningFile = value
    case let .setSelectedListType(type):
        state.selectedListType = type
    case let .setSelectedCategory(category):
        state.selectedCategory = category
    case let .setShowListDetail(value):
        state.isShowingListDetail = value
    case let .setIsShowingAddView(value):
        state.isShowingAddView = value
    case .showAddView:
        state.isShowingAddView = true
    }

    return ActionResult.none
}
