//
//  FingerViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI
import Combine

class FingerViewModel: ObservableObject {
    @Published var fingerWidth: Double = Constants.minFingerWidth
    @Published var ringSize: String = ""
    @Published var errorMessage: String?
    @Published var showingError: Bool = false
    
    private let measurementService = MeasurementService.shared
    
    init() {
        updateRingSize(width: fingerWidth)
    }
    
    private func updateRingSize(width: Double) {
        self.ringSize = measurementService.convertFingerToRingSize(fingerWidth: width)
    }
    
    func saveMeasurement(title: String) {
        do {
            try measurementService.saveMeasurement(title: title, size: fingerWidth, type: .finger)
        } catch {
            showError("측정 기록을 저장하는데 실패했습니다: \(error.localizedDescription)")
        }
    }
    
    func incrementWidth() {
        fingerWidth = min(fingerWidth + 0.1, Constants.maxFingerWidth)
        updateRingSize(width: fingerWidth)
    }
    
    func decrementWidth() {
        fingerWidth = max(fingerWidth - 0.1, Constants.minFingerWidth)
        updateRingSize(width: fingerWidth)
    }
    
    private func showError(_ message: String) {
        self.errorMessage = message
        self.showingError = true
    }
}
