//
//  AppStore.swift
//  DETimeLog
//
//  Created by martinhartl on 17.02.22.
//

import Foundation
import SwiftUI

final class AppStore: ObservableObject {
    struct State {
        var selectedListType: ListType? = .all
        var isOpeningFile = false
    }

    enum Action {
        case showFileOpener
        case hideFileOpener
        case setSelectedListType(ListType?)
    }

    func reduce(_ action: Action) {
        switch action {
        case .showFileOpener:
            state.isOpeningFile = true
        case .hideFileOpener:
            state.isOpeningFile = false
        case let .setSelectedListType(type):
            state.selectedListType = type
        }
    }

    @Published private var state = State()

    var isOpeningFile: Binding<Bool> {
        Binding { [weak self] in
            return self?.state.isOpeningFile ?? false
        } set: { [weak self] value in
            guard let self = self else { return }
            if value {
                self.reduce(.showFileOpener)
            } else {
                self.reduce(.hideFileOpener)
            }
        }
    }

    var selectedListType: Binding<ListType?> {
        Binding { [weak self] in
            return self?.state.selectedListType
        } set: { [weak self] type in
            guard let self = self else { return }
            self.reduce(.setSelectedListType(type))
        }
    }
}
