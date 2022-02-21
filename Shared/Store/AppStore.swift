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

struct AppState {
    var selectedListType: ListType? = .all
    var isOpeningFile = false
}

enum AppAction {
    case showFileOpener
    case isShowingFileOpener(Bool)
    case setSelectedListType(ListType?)
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
    }

    return ActionResult.none
}
