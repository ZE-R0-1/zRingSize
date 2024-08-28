//
//  HomeViewModel.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import Combine
import RealmSwift

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab = .ring
    @Published var recentMeasurements: [SizeRecord] = []
    @Published var errorMessage: String?
    @Published var showingError: Bool = false
    
    private var notificationToken: NotificationToken?
    private let measurementService = MeasurementService.shared
    
    init() {
        fetchRecentMeasurements()
        observeRealmChanges()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func observeRealmChanges() {
        let realm = try! Realm()
        notificationToken = realm.objects(SizeRecord.self).observe { [weak self] _ in
            self?.fetchRecentMeasurements()
        }
    }
    
    func fetchRecentMeasurements() {
        self.recentMeasurements = measurementService.getRecentMeasurements(limit: Constants.maxRecentMeasurements)
    }
    
    func changeTab(to tab: Tab) {
        self.selectedTab = tab
    }
    
    func updateMeasurements() {
        fetchRecentMeasurements()
    }
    
    private func showError(_ message: String) {
        self.errorMessage = message
        self.showingError = true
    }
}
