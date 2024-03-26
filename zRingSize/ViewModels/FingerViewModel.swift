//
//  FingerViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/26.
//

import SwiftUI
import CoreData

class FingerViewModel: ObservableObject {
    @Published var fingerThickness: Double = 10
    
    private let persistenceController = PersistenceController.shared
    
    func saveItem(title: String, size: Double) {
        let measurement = MeasurementEntity(context: persistenceController.container.viewContext)
        measurement.title = title
        measurement.size = size
        measurement.date = Date()
        
        persistenceController.saveContext()
    }
}
