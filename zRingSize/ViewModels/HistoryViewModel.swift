//
//  HistoryViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import RealmSwift

class HistoryViewModel: ObservableObject {
    @Published var measurements: [SizeRecord] = []
    @Published var errorMessage: String?
    @Published var showingError: Bool = false
    
    private var notificationToken: NotificationToken?
    private let measurementService = MeasurementService.shared
    
    init() {
        fetchMeasurements()
        observeRealmChanges()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func observeRealmChanges() {
        let realm = try! Realm()
        notificationToken = realm.objects(SizeRecord.self).observe { [weak self] _ in
            self?.fetchMeasurements()
        }
    }
    
    func fetchMeasurements() {
        self.measurements = measurementService.getMeasurements()
    }
    
    func deleteMeasurement(at indexSet: IndexSet) {
        for index in indexSet {
            let measurement = measurements[index]
            measurementService.deleteMeasurement(id: measurement.id)
        }
    }
    
    func getMeasurementDetails(_ measurement: SizeRecord) -> String {
        let sizeString = String(format: "%.1f", measurement.size)
        let typeString = measurement.type == SizeRecord.MeasurementType.ring.rawValue ? "반지 직경" : "손가락 둘레"
        return "\(typeString): \(sizeString) mm"
    }
    
    private func showError(_ message: String) {
        self.errorMessage = message
        self.showingError = true
    }
}
