//
//  Month.swift
//  DETimeLog
//
//  Created by martinhartl on 12.03.22.
//

import Foundation

struct Month: Identifiable, Equatable, Hashable {
    var dateString: String
    var entries: [Entry]

    var id: String {
        dateString
    }
}
