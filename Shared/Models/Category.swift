//
//  Category.swift
//  DETimeLog
//
//  Created by martinhartl on 18.02.22.
//

import Foundation

struct Category: Hashable, Identifiable, Codable {
    var title: String

    var id: String {
        title
    }
}

struct CategoryDuration: Identifiable {
    var category: Category
    var duration: TimeInterval

    var id: String {
        category.id
    }

    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: duration) ?? ""
    }
}
