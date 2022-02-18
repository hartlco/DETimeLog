//
//  LogStore.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

import Foundation
import SwiftUI

enum ListType: Hashable, Equatable {
    case all
}

final class EntryStore: ObservableObject {
    struct State {
        var entries: [Entry]
    }

    enum Action {
        case load(fileURL: URL)
    }

    @MainActor
    func reduce(_ action: Action) {
        switch action {
        case let .load(fileURL):
            Task {
                do {
                    state.entries = try await fileParser.parse(fileURL: fileURL)
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
