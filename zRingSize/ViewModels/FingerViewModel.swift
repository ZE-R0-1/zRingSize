//
//  FingerViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI
import Combine

class FingerViewModel: ObservableObject {
    @Published var fingerWidth: Double = Constants.minFingerWidth {
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
        let fingerCircumference = SizeModel.ringDiameterToFingerCircumference(fingerWidth)
        let equivalentRingDiameter = SizeModel.fingerCircumferenceToRingDiameter(fingerCircumference)
        self.ringSize = SizeModel.getRingSize(for: equivalentRingDiameter)
    }
    
    func saveMeasurement(title: String) {
        do {
            try measurementService.saveMeasurement(title: title, size: fingerWidth, type: .ring)
        } catch {
            self.errorMessage = "측정 기록을 저장하는데 실패했습니다: \(error.localizedDescription)"
            self.showingError = true
        }
    }
    
    func incrementWidth() {
        fingerWidth = min(fingerWidth + 0.1, Constants.maxFingerWidth)
    }
    
    func decrementWidth() {
        fingerWidth = max(fingerWidth - 0.1, Constants.minFingerWidth)
    }
}
