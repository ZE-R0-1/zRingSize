//
//  HistoryViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import RealmSwift
import Combine
import Foundation

// 측정 기록 화면을 위한 ViewModel
class HistoryViewModel: ObservableObject {
    // 최근 측정 기록
    @Published var recentMeasurements: [SizeRecord] = []
    // 모든 측정 기록
    @Published var allMeasurements: [SizeRecord] = []
    // 오류 메시지
    @Published var errorMessage: String?
    // 오류 표시 여부
    @Published var showingError: Bool = false

    // Realm 변경 알림을 위한 토큰
    private var notificationToken: NotificationToken?
    // 측정 서비스 인스턴스
    private let measurementService = MeasurementService.shared

    // 초기화 메서드
    init() {
        fetchMeasurements()
        observeRealmChanges()
    }

    // 소멸자: Realm 알림 토큰 해제
    deinit {
        notificationToken?.invalidate()
    }

    // Realm 데이터 변경 감지 메서드
    private func observeRealmChanges() {
        let realm = try! Realm()
        notificationToken = realm.objects(SizeRecord.self).observe { [weak self] _ in
            self?.fetchMeasurements()
        }
    }

    // 측정 기록 가져오기
    func fetchMeasurements() {
        self.allMeasurements = measurementService.getMeasurements()
        self.recentMeasurements = measurementService.getRecentMeasurements(limit: Constants.maxRecentMeasurements)
    }

    // 측정 기록 삭제
    func deleteMeasurement(id: UUID) {
        measurementService.deleteMeasurement(id: id)
        fetchMeasurements()
    }

    // 측정 기록 상세 정보 문자열 생성
    func getMeasurementDetails(_ measurement: SizeRecord) -> String {
        let sizeString = String(format: "%.1f", measurement.size * .pi)
        let typeString = measurement.type == SizeRecord.MeasurementType.ring.rawValue ? "반지 직경" : "손가락 둘레"
        return "\(typeString): \(sizeString) mm"
    }
    
    // 예상 반지 사이즈 계산
    func getEstimatedRingSize(_ measurement: SizeRecord) -> String {
        let diameter: Double
        if measurement.type == SizeRecord.MeasurementType.ring.rawValue {
            diameter = measurement.size
        } else {
            // 손가락 둘레를 직경으로 변환
            diameter = SizeModel.fingerCircumferenceToRingDiameter(measurement.size)
        }
        return SizeModel.getRingSize(for: diameter)
    }

    // 손가락 둘레 계산
    func getFingerCircumference(_ measurement: SizeRecord) -> String {
        if measurement.type == SizeRecord.MeasurementType.ring.rawValue {
            return String(format: "%.1f mm", SizeModel.ringDiameterToFingerCircumference(measurement.size))
        } else {
            return String(format: "%.1f mm", measurement.size)
        }
    }
    
    // 오류 표시
    private func showError(_ message: String) {
        self.errorMessage = message
        self.showingError = true
    }
}
