//
//  SettingsViewModel.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @AppStorage("vibrationEnabled") var isVibrationEnabled: Bool = true
    @AppStorage("measurementUnit") var measurementUnit: MeasurementUnit = .millimeter
    @Published var appVersion: String = ""
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    enum MeasurementUnit: String, CaseIterable {
        case millimeter = "mm"
        case inch = "in"
    }
    
    init() {
        loadAppVersion()
    }
    
    func toggleVibration() {
        isVibrationEnabled.toggle()
        if isVibrationEnabled {
            performHapticFeedback()
        }
    }
    
    func changeMeasurementUnit(to unit: MeasurementUnit) {
        measurementUnit = unit
        performHapticFeedback()
    }
    
    private func loadAppVersion() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.appVersion = version
        } else {
            self.appVersion = "Unknown"
        }
    }
    
    private func performHapticFeedback() {
        if isVibrationEnabled {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
        }
    }
    
    func resetAllSettings() {
        isVibrationEnabled = true
        measurementUnit = .millimeter
        performHapticFeedback()
    }
    
    func convertMeasurement(_ value: Double, from: MeasurementUnit, to: MeasurementUnit) -> Double {
        switch (from, to) {
        case (.millimeter, .inch):
            return value / 25.4
        case (.inch, .millimeter):
            return value * 25.4
        default:
            return value
        }
    }
}
