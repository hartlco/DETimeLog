//
//  AppStore.swift
//  DETimeLog
//
//  Created by martinhartl on 17.02.22.
//

import Foundation
import SwiftUI

typealias AppViewStore = ViewStore<AppState, AppAction, AppEnvironment>

extension AppViewStore {
    @MainActor
    var isOpeningFileBinding: Binding<Bool> {
        binding(get: \.isOpeningFile, send: { .isShowingFileOpener($0) })
    }
}

struct AppState {
    var selectedListType: ListType? = .all
    var isOpeningFile = false
}

enum AppAction {
    case showFileOpener
    case isShowingFileOpener(Bool)
    case setSelectedListType(ListType?)
}

struct AppEnvironment { }

let appReducer: ReduceFunction<AppState, AppAction, AppEnvironment> = { state, action, env in
    switch action {
    case .showFileOpener:
        state.isOpeningFile = true
    case let .isShowingFileOpener(value):
        state.isOpeningFile = value
    case let .setSelectedListType(type):
        state.selectedListType = type
    }
}
