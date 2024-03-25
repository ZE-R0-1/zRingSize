//
//  RingSizerViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import CoreData

class RingSizerViewModel: ObservableObject {
    @Published var ringSize: Double = 0
    @Published var fingerThickness: Double = 0
    @Published var savedSizes: [Double] = []
    
    func saveSize(context: NSManagedObjectContext, size: Double) {
        RingSizeEntity.create(in: context, size: size)
        fetchSavedSizes(context: context)
    }
    
    func saveFingerThickness(context: NSManagedObjectContext, fingerThickness: Double) {
        FingerThicknessEntity.create(in: context, thickness: fingerThickness)
        fetchSavedSizes(context: context)
    }
    
    func fetchSavedSizes(context: NSManagedObjectContext) {
        savedSizes = RingSizeEntity.fetchAllSizes(context: context)
    }
    
    func deleteSize(at offsets: IndexSet, context: NSManagedObjectContext) {
        for index in offsets {
            let sizeToDelete = savedSizes[index]
            RingSizeEntity.deleteSize(size: sizeToDelete, context: context)
        }
        fetchSavedSizes(context: context)
    }
}
