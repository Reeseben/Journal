//
//  Entry.swift
//  Journal
//
//  Created by Ben Erekson on 7/19/21.
//

import Foundation

class Entry: Codable {
    var title: String
    var text: String
    let date: Date

    
    init(title: String, text: String){
        self.title = title
        self.text = text
        self.date = Date()
    }
    
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool{
        return lhs.title == rhs.title && lhs.text == rhs.text && rhs.date == lhs.date
    }
}
