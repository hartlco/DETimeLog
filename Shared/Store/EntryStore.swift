//
//  LogStore.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

@_predatesConcurrency
import Foundation
import SwiftUI
import ViewStore

typealias EntryViewStore = ViewStore<EntryState, EntryAction, EntryEnvironment>

enum ListType: Hashable, Equatable {
    case all
    case filtered(day: Day)
    case categoryFilter(category: Category)
    case categories
}

struct EntryState: Sendable {
    var entries: [Entry] = []
    var categories: [Category] = []
    var colorsByCategory: [Category: CGColor] = [:]
    var days: [Day] = []
}

enum EntryAction: Sendable {
    case loadLastOpenedFile
    case load(fileURL: URL)
    case categoryColorAction(Category, CategoryColorAction)
}

struct EntryEnvironment {
    let userDefaults: UserDefaults = .standard
    let fileParser: FileParser
    let colorStore: ColorStore
}

let entryReducer: ReduceFunction<EntryState, EntryAction, EntryEnvironment> = { state, action, environment in
    switch action {
    case .loadLastOpenedFile:
        var isStale = false

        guard let lastOpenendBookmarkData = environment.userDefaults.lastOpenedBookmarkData,
              let fileURL = try? URL(
                resolvingBookmarkData: lastOpenendBookmarkData,
                bookmarkDataIsStale: &isStale
              ) else { return .none }

        return .perform(.load(fileURL: fileURL))
    case let .load(fileURL):
        do {
            let parseResult = try await environment.fileParser.parse(fileURL: fileURL)
            state.entries = parseResult.entries
            state.categories = parseResult.categories
            state.colorsByCategory = environment.colorStore.colors(for: parseResult.categories)
            state.days = days(from: parseResult.entries)
            environment.userDefaults.lastOpenedBookmarkData = parseResult.bookmarkData
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

    return .none
}

func days(from entries: [Entry]) -> [Day] {
    let result = entries.reduce(into: [String: [Entry]]()) { partialResult, entry in
        let dateString = entry.date.formatted(date: .numeric, time: .omitted)
        var entries = partialResult[dateString] ?? []
        entries.append(entry)
        partialResult[dateString] = entries
    }

    return result
        .map { key, value in
            Day(dateString: key, entries: value)
        }
        .sorted { day1, day2 in
            day1.dateString < day2.dateString
        }
}

extension UserDefaults {
    var lastOpenedBookmarkData: Data? {
        get {
            data(forKey: #function)
        }
        set {
            set(newValue, forKey: #function)
        }
    }
}

extension EntryViewStore {
    func entries(for listType: ListType) -> [Entry] {
        switch listType {
        case .all:
            return entries
        case .filtered(let day):
            let foundDay = self.days.first {
                day == $0
            }

            return foundDay?.entries ?? []
        case let .categoryFilter(category):
            return self.entries.filter {
                $0.category == category
            }
        case .categories:
            return []
        }
    }

    func categoryDurations(for listType: ListType) -> [CategoryDuration] {
        let entries = entries(for: listType)


        return entries.reduce(into: [CategoryDuration]()) { partialResult, entry in
            let firstIndex = partialResult.firstIndex {
                $0.category == entry.category
            }

            var existingDuration: CategoryDuration
            if let firstIndex = firstIndex {
                existingDuration = partialResult.remove(at: firstIndex)
            } else {
                existingDuration = CategoryDuration(category: entry.category, duration: 0)
            }

            existingDuration.duration = existingDuration.duration + (entry.duration ?? 0)
            partialResult.append(existingDuration)
        }
    }
}
