//
//  SettingsViewModel.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI
import Combine

// 설정 화면을 위한 ViewModel
class SettingsViewModel: ObservableObject {
    // 진동 설정 (UserDefaults에 저장)
    @AppStorage("vibrationEnabled") var isVibrationEnabled: Bool = false
    // 측정 단위 설정 (UserDefaults에 저장)
    @AppStorage("measurementUnit") var measurementUnit: MeasurementUnit = .millimeter
    // 앱 버전
    @Published var appVersion: String = ""
    // 오류 메시지
    @Published var errorMessage: String?
    
    // Combine 구독을 저장하기 위한 Set
    private var cancellables = Set<AnyCancellable>()
    
    // 측정 단위 열거형
    enum MeasurementUnit: String, CaseIterable {
        case millimeter = "mm"
        case inch = "in"
    }
    
    init() {
        loadAppVersion()
    }
    
    // 진동 설정 토글
    func toggleVibration() {
        isVibrationEnabled.toggle()
        if isVibrationEnabled {
            performHapticFeedback()
        }
    }
    
    // 측정 단위 변경
    func changeMeasurementUnit(to unit: MeasurementUnit) {
        measurementUnit = unit
        performHapticFeedback()
    }
    
    // 앱 버전 로드
    private func loadAppVersion() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.appVersion = version
        } else {
            self.appVersion = "Unknown"
        }
    }
    
    // 햅틱 피드백 수행
    func performHapticFeedback() {
        if isVibrationEnabled {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
    }
    
    // 모든 설정 초기화
    func resetAllSettings() {
        isVibrationEnabled = true
        measurementUnit = .millimeter
        performHapticFeedback()
    }
    
    // 측정 단위 변환
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
