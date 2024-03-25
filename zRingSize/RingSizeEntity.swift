//
//  RingSizeEntity.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import CoreData

extension RingSizeEntity {
    static func create(in managedObjectContext: NSManagedObjectContext, size: Double) {
        let newSize = RingSizeEntity(context: managedObjectContext)
        newSize.id = UUID()
        newSize.sizeValue = size
        newSize.dateAdded = Date()
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving new ring size: \(error)")
        }
    }
    
    static func fetchAllSizes(context: NSManagedObjectContext) -> [Double] {
        let request: NSFetchRequest<RingSizeEntity> = RingSizeEntity.fetchRequest()
        do {
            let result = try context.fetch(request)
            return result.map { $0.sizeValue }
        } catch {
            print("Error fetching saved sizes: \(error)")
            return []
        }
    }
    
    static func deleteSize(size: Double, context: NSManagedObjectContext) {
        let request: NSFetchRequest<RingSizeEntity> = RingSizeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "sizeValue == %lf", size)
        do {
            let results = try context.fetch(request)
            for result in results {
                context.delete(result)
            }
            try context.save()
        } catch {
            print("Error deleting size: \(error)")
        }
    }
}

