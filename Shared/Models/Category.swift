//
//  Category.swift
//  DETimeLog
//
//  Created by martinhartl on 18.02.22.
//

import Foundation

struct Category: Hashable, Identifiable {
    var title: String

    var id: String {
        title
    }
}
