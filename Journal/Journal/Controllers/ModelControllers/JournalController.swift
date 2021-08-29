//
//  JournalController.swift
//  Journal
//
//  Created by Ben Erekson on 7/20/21.
//

import Foundation

class JournalController {
    static var sharedInstance = JournalController()
    var journals: [Journal] = []
    
    //MARK: - CRUD FUNCTIONS
    
    func createJournalWith(title: String){
        journals.append(Journal(title: title))
        saveToPresistenceStore()
    }
    
    func delete(journal: Journal){
        guard let index = journals.firstIndex(of: journal) else {return}
        journals.remove(at: index)
        saveToPresistenceStore()
    }
    
    //MARK: - Entry functions
    func newEntry(title: String, body: String, journal: Journal){
        let entry = Entry(title: title, text: body)
        journal.entries.append(entry)
        saveToPresistenceStore()
    }
    
    func updateEntry(entry: Entry, journal: Journal, newTitle: String, newText: String){
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        journal.entries[index].title = newTitle
        journal.entries[index].text = newText
        saveToPresistenceStore()
    }
    
    func deleteEntry(entry: Entry, journal: Journal){
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        journal.entries.remove(at: index)
        saveToPresistenceStore()
    }
    
    //MARK: - Persistance
    func createPresistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    func saveToPresistenceStore() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: createPresistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPresistenceStore() {
        do {
            let data = try Data(contentsOf: createPresistenceStore())
            journals = try JSONDecoder().decode([Journal].self, from: data)
            
        }catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    
}
