//
//  FileInserter.swift
//  DETimeLog
//
//  Created by martinhartl on 15.03.22.
//

import Foundation

enum InsertError: Error {
    case accessDenied
}

final class FileInserter {
    func append(string: String, to fileURL: URL) throws {
        guard fileURL.startAccessingSecurityScopedResource() else {
            throw InsertError.accessDenied
        }

        // TODO: Use FilePresenter: https://developer.apple.com/documentation/uikit/uidocumentpickerviewcontroller

        defer { fileURL.stopAccessingSecurityScopedResource() }

        try string.appendLineToURL(fileURL: fileURL)
    }
}

// https://stackoverflow.com/a/40687742
extension String {
    func appendLineToURL(fileURL: URL) throws {
         try (self + "\n").appendToURL(fileURL: fileURL)
     }

     func appendToURL(fileURL: URL) throws {
         let data = self.data(using: String.Encoding.utf8)!
         try data.append(fileURL: fileURL)
     }
 }

 extension Data {
     func append(fileURL: URL) throws {
         if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
             defer {
                 fileHandle.closeFile()
             }
             fileHandle.seekToEndOfFile()
             fileHandle.write(self)
         }
         else {
             try write(to: fileURL, options: .atomic)
         }
     }
 }
