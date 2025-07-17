//
//  Note+CoreDataProperties.swift
//  NotasApp
//
//  Created by Florent Tino on 16/07/25.
//
//

import Foundation
import CoreData


extension NoteEntitty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntitty> {
        return NSFetchRequest<NoteEntitty>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

//extension Note : Identifiable {
//
//}
