//
//  FingerViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI
import Combine

// 손가락 크기 측정을 위한 ViewModel
class FingerViewModel: ObservableObject {
    // 손가락 너비 (변경 시 자동으로 반지 사이즈 업데이트)
    @Published var fingerWidth: Double = Constants.minFingerWidth {
        didSet {
            updateRingSize()
        }
    }
    // 계산된 반지 사이즈 (예: "10호")
    @Published var ringSize: String = ""
    // 오류 메시지
    @Published var errorMessage: String?
    // 오류 표시 여부
    @Published var showingError: Bool = false
    
    // 측정 서비스 인스턴스
    private let measurementService = MeasurementService.shared
    
    // 초기화 시 반지 사이즈 업데이트
    init() {
        updateRingSize()
    }
    
    // 손가락 너비에 따른 반지 사이즈 업데이트
    private func updateRingSize() {
        let fingerCircumference = SizeModel.ringDiameterToFingerCircumference(fingerWidth)
        let equivalentRingDiameter = SizeModel.fingerCircumferenceToRingDiameter(fingerCircumference)
        self.ringSize = SizeModel.getRingSize(for: equivalentRingDiameter)
    }
    
    // 측정 결과 저장
    func saveMeasurement(title: String) {
        do {
            try measurementService.saveMeasurement(title: title, size: fingerWidth, type: .finger)
        } catch {
            self.errorMessage = "측정 기록을 저장하는데 실패했습니다: \(error.localizedDescription)"
            self.showingError = true
        }
    }
    
    // 손가락 너비 증가 (최대값 제한)
    func incrementWidth() {
        fingerWidth = min(fingerWidth + 0.1, Constants.maxFingerWidth)
    }
    
    // 손가락 너비 감소 (최소값 제한)
    func decrementWidth() {
        fingerWidth = max(fingerWidth - 0.1, Constants.minFingerWidth)
    }
}
