//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import RealmSwift
import Combine

class RingViewModel: ObservableObject {
    @Published var ringDiameter: Double = Constants.minRingDiameter
    @Published var ringSize: String = ""
    @Published var errorMessage: String?
    @Published var showingError: Bool = false
    @Published var recentMeasurements: [SizeRecord] = []
    
    private var notificationToken: NotificationToken?
    private let measurementService = MeasurementService.shared
    
    init() {
        updateRingSize(diameter: ringDiameter)
        loadRecentMeasurements()
        observeRealmChanges()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func observeRealmChanges() {
        let realm = try! Realm()
        notificationToken = realm.objects(SizeRecord.self).observe { [weak self] changes in
            self?.loadRecentMeasurements()
        }
    }
    
    private func updateRingSize(diameter: Double) {
        self.ringSize = measurementService.calculateRingSize(diameter: diameter)
    }
    
    func saveMeasurement(title: String) {
        do {
            try measurementService.saveMeasurement(title: title, size: ringDiameter, type: .ring)
            loadRecentMeasurements()
        } catch {
            self.errorMessage = "측정 기록을 저장하는데 실패했습니다: \(error.localizedDescription)"
            self.showingError = true
        }
    }
    
    func incrementDiameter() {
        ringDiameter = min(ringDiameter + 0.1, Constants.maxRingDiameter)
    }
    
    func decrementDiameter() {
        ringDiameter = max(ringDiameter - 0.1, Constants.minRingDiameter)
    }
    
    private func loadRecentMeasurements() {
        recentMeasurements = measurementService.getRecentMeasurements(limit: 5)
    }
}
