//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

// 반지 크기 측정을 위한 ViewModel
class RingViewModel: ObservableObject {
    // 반지 내경 (mm). 값이 변경되면 반지 사이즈를 업데이트함
    @Published var ringDiameter: Double = Constants.minRingDiameter {
        didSet {
            updateRingSize()
        }
    }
    
    // 계산된 반지 사이즈 (예: "10호")
    @Published var ringSize: String = ""
    
    // 오류 메시지 저장
    @Published var errorMessage: String?
    
    // 오류 표시 여부
    @Published var showingError: Bool = false
    
    // 측정 데이터를 저장하기 위한 서비스
    private let measurementService = MeasurementService.shared
    
    // 초기화 시 반지 사이즈 업데이트
    init() {
        updateRingSize()
    }
    
    // 현재 내경에 해당하는 반지 사이즈 업데이트
    private func updateRingSize() {
        self.ringSize = SizeModel.getRingSize(for: ringDiameter)
    }
    
    // 측정 결과 저장
    func saveMeasurement(title: String) {
        do {
            try measurementService.saveMeasurement(title: title, size: ringDiameter, type: .ring)
        } catch {
            self.errorMessage = "측정 기록을 저장하는데 실패했습니다: \(error.localizedDescription)"
            self.showingError = true
        }
    }
    
    // 내경을 0.1mm 증가 (최대값 제한)
    func incrementDiameter() {
        ringDiameter = min(ringDiameter + 0.1, Constants.maxRingDiameter)
    }
    
    // 내경을 0.1mm 감소 (최소값 제한)
    func decrementDiameter() {
        ringDiameter = max(ringDiameter - 0.1, Constants.minRingDiameter)
    }
}
