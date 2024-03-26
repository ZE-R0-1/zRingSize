//
//  HistoryViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/26.
//

import CoreData

class HistoryViewModel: ObservableObject {
    @Published var measurements: [MeasurementEntity] = []
    
    private let persistenceController = PersistenceController.shared
    
    init() {
        fetchMeasurements()
    }
    
    private func fetchMeasurements() {
        let fetchRequest: NSFetchRequest<MeasurementEntity> = MeasurementEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            measurements = try persistenceController.container.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch measurements: \(error)")
        }
    }
}

