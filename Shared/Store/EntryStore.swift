//
//  LogStore.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

import Foundation
import SwiftUI

final class EntryStore: ObservableObject {
    struct State {
        var entries: [Entry]
    }

    enum Action {
        case load
    }

    @MainActor
    func reduce(_ action: Action) {
        switch action {
        case .load:
            Task {
                do {
                    state.entries = try await fileParser.parse()
                }
            }
        }
    }

    private let fileParser = FileParser()
    @Published private var state = State(entries: [])

    var entries: [Entry] {
        state.entries
    }
}
