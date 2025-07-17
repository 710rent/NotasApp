//
//  CoreDataHelper.swift
//  NotasApp
//
//  Created by Florent Tino on 16/07/25.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "notas_model")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error al cargar store: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func AddNote(title:String, description:String) {
        let note = NoteEntitty(context: CoreDataHelper.shared.context)
        note.title = title
        note.content = description
        note.date = Date()
        
        CoreDataHelper.shared.saveContext()
    }
    
    func GetNotes() -> [NoteEntitty] {
        let fetchRequest: NSFetchRequest<NoteEntitty> = NoteEntitty.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let notes = (try? CoreDataHelper.shared.context.fetch(fetchRequest)) ?? []
        
        return notes
    }
    
    func RemoveNote(note: NoteEntitty){
        CoreDataHelper.shared.context.delete(note)
        CoreDataHelper.shared.saveContext()
    }
    
}
