//
//  EntryController.swift
//  Journal
//
//  Created by Ben Erekson on 7/19/21.
//

import Foundation

class EntryController {
    
    static func createEntryWith(title: String, body: String, journal: Journal) {
        JournalController.sharedInstance.newEntry(title: title, body: body, journal: journal)
    }
    
    static func updateEntry(entry: Entry, newTitle: String, newBody: String, journal: Journal){
        JournalController.sharedInstance.updateEntry(entry: entry, journal: journal, newTitle: newTitle, newText: newBody)
    }
    
    static func delete(entry: Entry, journal: Journal){
        JournalController.sharedInstance.deleteEntry(entry: entry, journal: journal)
    }
    
}
