//
//  Day.swift
//  DETimeLog
//
//  Created by martinhartl on 21.02.22.
//

import Foundation

struct Day: Identifiable, Equatable, Hashable {
    let dateString: String
    let entries: [Entry]

    var id: String {
        dateString
    }
}
