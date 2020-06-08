//
//  CoreDataRepository.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 6.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataRepositoryProtocol: class {
    
    func save<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws
    func getFirst<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws -> T?
    func getAll<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws -> [T]?
    func deleteFirst<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws
    func deleteAll<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws
}

class CoreDataRepository: CoreDataRepositoryProtocol {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WorkoutLogger")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    private lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func save<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws {
        let object = T(context: managedContext)
        for (key, value) in values {
            if object.entity.propertiesByName.keys.contains(key) {
                object.setValue(value, forKey: key)
            }
        }
        
        try managedContext.save()
    }
    
    func deleteFirst<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws {
        guard let fetchRequest = setupFetchRequest(for: object, with: values) else { return }
        
        fetchRequest.fetchLimit = 1
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try managedContext.execute(deleteRequest)
    }
    
    func deleteAll<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws {
        guard let fetchRequest = setupFetchRequest(for: object, with: values) else { return }
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try managedContext.execute(deleteRequest)
    }
    
    func getAll<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws -> [T]? {
        guard let fetchRequest = setupFetchRequest(for: object, with: values) else { return nil }
        
        return try managedContext.fetch(fetchRequest) as? [T]
    }
    
    func getFirst<T: NSManagedObject>(object: T.Type, with values: [String: Any]) throws -> T? {
        guard let fetchRequest = setupFetchRequest(for: object, with: values) else { return nil }
        
        fetchRequest.fetchLimit = 1
        return try managedContext.fetch(fetchRequest).first as? T
    }
    
    private func setupFetchRequest<T: NSManagedObject>(for object: T.Type, with values: [String: Any]) -> NSFetchRequest<NSFetchRequestResult>? {
        let object = T(context: managedContext)
        let properties = object.entity.propertiesByName.keys
        let existingValues = values.filter { properties.contains($0.key) }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(T.self)")
        var predicates = [NSPredicate]()
        for (key, value) in existingValues {
            let predicate = NSPredicate(format: "\(key) = %@", "\(value)")
            predicates.append(predicate)
        }
        
        guard !predicates.isEmpty else { return nil }
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        fetchRequest.predicate = compoundPredicate
        return fetchRequest
    }
}
