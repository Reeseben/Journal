//
//  Entry+Convenience.swift
//  Journal
//
//  Created by Ben Erekson on 7/23/21.
//

import Foundation
import CoreData

extension Entry {
    
    convenience init(titile: String, text: String, timestamp: Date = Date(), context: NSManagedObjectContext) {
        
        self.init(context: context){
            
            self.title = title
            self.text = text
            self.timestamp = timestamp
        }
    }
}
