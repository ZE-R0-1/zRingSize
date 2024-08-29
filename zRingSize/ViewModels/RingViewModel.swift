//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

class RingViewModel: ObservableObject {
    @Published var ringDiameter: Double = Constants.minRingDiameter {
        didSet {
            updateRingSize()
        }
    }
    @Published var ringSize: String = ""
    @Published var errorMessage: String?
    @Published var showingError: Bool = false
    
    private let measurementService = MeasurementService.shared
    
    init() {
        updateRingSize()
    }
    
    private func updateRingSize() {
        self.ringSize = SizeModel.getRingSize(for: ringDiameter)
    }
    
    func saveMeasurement(title: String) {
        do {
            try measurementService.saveMeasurement(title: title, size: ringDiameter, type: .ring)
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
}
