//
//  CoreDataFetchService.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//


import Foundation
import CoreData

class CoreDataFetchService {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Uber_Clone")
        container.loadPersistentStores { description, error in
            if error != nil { print("Error loading data") }
            else { print("Successfully loaded data") }
        }
    }
    
    func fetchData() -> [SavedLocation] {
        let request = NSFetchRequest<SavedLocation>(entityName: "SavedLocation")
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching data")
        }
        
        return []
    }
}
