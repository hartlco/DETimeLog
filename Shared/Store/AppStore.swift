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
        var isOpeningFile = false
    }

    enum Action {
        case showFileOpener
        case hideFileOpener
    }

    func reduce(_ action: Action) {
        switch action {
        case .showFileOpener:
            state.isOpeningFile = true
        case .hideFileOpener:
            state.isOpeningFile = false
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
}
