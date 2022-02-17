//
//  FileParser.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

import Foundation

enum ParseError: Error {
    case accessDenied
    case invalidInputFile
    case invalidCSVRow
    case invalidDate
}

final class FileParser {
    func parse(fileURL: URL) async throws -> [Entry] {
        if fileURL.startAccessingSecurityScopedResource() {
            guard let input = String(data: try Data(contentsOf: fileURL), encoding: .utf8) else { throw ParseError.invalidInputFile }
            defer { fileURL.stopAccessingSecurityScopedResource() }
            let lines = input
                .components(separatedBy: "\n")
            // TODO: Check if header is set correct
                .dropFirst()
                .sorted()
                .reversed()
            var entries: [Entry] = []
            for line in lines {
                if line.isEmpty {
                    continue
                }
                
                let endDate = entries.last?.date
                let entry = try Entry(fromCSVString: line, endDate: endDate)

                entries.append(entry)
            }
            return entries
        } else {
            throw ParseError.accessDenied
        }
    }
}
