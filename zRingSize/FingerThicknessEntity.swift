//
//  FingerThicknessEntity.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import CoreData

extension FingerThicknessEntity {
    static func create(in managedObjectContext: NSManagedObjectContext, thickness: Double) {
        let newThickness = FingerThicknessEntity(context: managedObjectContext)
        newThickness.id = UUID()
        newThickness.thicknessValue = thickness
        newThickness.dateAdded = Date()
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving new finger thickness: \(error)")
        }
    }
}
