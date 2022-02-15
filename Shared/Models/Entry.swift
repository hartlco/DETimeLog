//
//  Entry.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

import Foundation

struct Entry: Identifiable {
    var date: Date
    // TODO: make sub-type
    var category: String
    var title: String
    var description: String

    var endDate: Date?

    let id = UUID()

    var duration: TimeInterval? {
        guard let endDate = endDate else {
            return nil
        }

        return endDate.timeIntervalSince1970 - date.timeIntervalSince1970
    }

    var formattedDuration: String {
        guard let duration = duration else {
            return ""
        }

        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: duration) ?? ""
    }
}

extension Entry {
    init(fromCSVString csv: String, endDate: Date?) throws {
        let components = csv.components(separatedBy: ",")

        guard components.count > 1 else {
            throw ParseError.invalidCSVRow
        }

        guard let date = ISO8601DateFormatter().date(from: components[0]) else {
            throw ParseError.invalidDate
        }

        self.date = date
        self.endDate = endDate
        self.category = components[1]
        self.title = components.count > 2 ? components[2] : ""
        self.description = components.count > 3 ? components[3] : ""
    }
}
