//
//  FileParser.swift
//  DETimeLog
//
//  Created by martinhartl on 15.02.22.
//

import Foundation

enum ParseError: Error {
    case invalidCSVRow
    case invalidDate
}

final class FileParser {
    func parse() async throws -> [Entry] {
        // TODO: Fix, read line by line
        let lines = testString
            .components(separatedBy: "\n")
            .reversed()
        var entries: [Entry] = []
        for line in lines {
            let endDate = entries.last?.date
            let entry = try Entry(fromCSVString: line, endDate: endDate)

            entries.append(entry)
        }
        return entries.sorted {
            $0.date > $1.date
        }
    }
}

// TODO: Drop first line when reading
let testString = """
2022-02-13T07:00:38+01:00,productivity,Setup Time Tracking,
2022-02-12T23:00:57+01:00,schlafen,,
2022-02-13T08:30:00+01:00,productivity,Mail,
2022-02-13T08:30:00+01:00,social media,,
2022-02-13T08:39:03+01:00,projekte,aarle,
2022-02-13T08:50:38+01:00,productivity,Obsidian backup,
2022-02-13T08:54:00+01:00,sport,,
2022-02-13T09:24:00+01:00,bad,,
2022-02-13T09:52:00+01:00,productivity,Time Tracking,Datei zu git schieben
2022-02-13T10:05:00+01:00,undefiniert,,
2022-02-13T10:13:00+01:00,einkaufen,,
2022-02-13T11:29:00+01:00,kochen,,
2022-02-13T12:12:00+01:00,essen,,
2022-02-13T12:41:00+01:00,haushalt,,
2022-02-13T12:55:00+01:00,haushalt,Bett überziehen,Bett überziehen
2022-02-13T13:22:00+01:00,freizeitaktivität,Spazieren,Cafe Kraft in Pankow
2022-02-13T14:35:00+01:00,youtube,,
2022-02-13T15:15:00+01:00,productivity,Mac Aufräumen,
2022-02-13T15:30:00+01:00,freizeitaktivität,Bilder machen,Selfies mit Martina
2022-02-13T16:00:00+01:00,hochzeit,Emails schreiben,Location und Videographen
2022-02-13T16:15:00+01:00,undefiniert,Wohnung umstellen,Wohnung umstellen
2022-02-13T16:49:00+01:00,hochzeit,Mails,Mails
2022-02-13T17:26:00+01:00,undefiniert,Möbel bestellen,Möbel bestellen
2022-02-13T17:37:00+01:00,productivity,Time Tracking,Time Tracking
2022-02-13T18:00:00+01:00,kochen,,
2022-02-13T19:00:00+01:00,essen,,
2022-02-13T19:15:00+01:00,undefiniert,,
2022-02-13T20:10:00+01:00,haushalt,,
2022-02-13T20:34:00+01:00,undefiniert,,
2022-02-13T20:40:00+01:00,tv,Attack on Titan,
2022-02-13T21:00:00+01:00,social media,,
2022-02-13T22:06:00+01:00,schlafen,,
2022-02-14T07:00:00+01:00,undefiniert,,
2022-02-14T07:47:00+01:00,bad,,
2022-02-14T08:10:00+01:00,kochen,,
2022-02-14T08:30:00+01:00,projekte,aarle,
2022-02-14T08:52:00+01:00,productivity,Time Tracking,
2022-02-14T09:01:18+01:00,arbeit,,
2022-02-14T12:30:49+01:00,kochen,,
2022-02-14T13:10:00+01:00,essen,,
2022-02-14T14:00:00+01:00,arbeit,,
2022-02-14T19:20:06+01:00,undefiniert,,
2022-02-14T19:55:00+01:00,essen,,
2022-02-14T20:14:19+01:00,undefiniert,,
2022-02-14T22:20:00+01:00,schlafen,,
2022-02-15T06:34:00+01:00,social media,,
2022-02-15T06:50:00+01:00,productivity,,
2022-02-15T07:05:00+01:00,sport,,
2022-02-15T07:34:00+01:00,bad,,
2022-02-15T08:00:00+01:00,haushalt,,
2022-02-15T08:19:00+01:00,projekte,DETimeLog,
"""
