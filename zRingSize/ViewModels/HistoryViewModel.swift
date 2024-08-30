//
//  HistoryViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import RealmSwift
import Combine
import Foundation

class HistoryViewModel: ObservableObject {
    // 발행된 속성들: SwiftUI 뷰가 이 변경사항을 관찰하고 UI를 업데이트합니다.
    @Published var allMeasurements: [SizeRecord] = []
    @Published var errorMessage: String?
    @Published var showingError: Bool = false

    // Realm 관련 프로퍼티
    private var notificationToken: NotificationToken?
    private let measurementService = MeasurementService.shared
    private var realm: Realm?

    init() {
        setupRealm()
        fetchMeasurements()
        observeRealmChanges()
    }

    deinit {
        // 뷰 모델이 해제될 때 노티피케이션 토큰을 무효화합니다.
        notificationToken?.invalidate()
    }

    // Realm 인스턴스를 설정하는 메서드
    private func setupRealm() {
        do {
            realm = try Realm()
        } catch {
            showError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }

    // Realm 변경사항을 관찰하는 메서드
    private func observeRealmChanges() {
        guard let realm = realm else { return }
        notificationToken = realm.objects(SizeRecord.self).observe { [weak self] _ in
            DispatchQueue.main.async {
                self?.fetchMeasurements()
            }
        }
    }

    // 측정 기록을 가져오는 메서드
    func fetchMeasurements() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let realm = self.realm else { return }
            let records = realm.objects(SizeRecord.self).sorted(byKeyPath: "date", ascending: false)
            // freeze()를 사용하여 스레드 안전성 보장
            self.allMeasurements = Array(records.freeze())
        }
    }

    // 측정 기록을 삭제하는 메서드
    func deleteMeasurement(id: UUID) {
        guard let realm = realm else { return }
        DispatchQueue.main.async { [weak self] in
            do {
                try realm.write {
                    if let objectToDelete = realm.object(ofType: SizeRecord.self, forPrimaryKey: id) {
                        realm.delete(objectToDelete)
                    }
                }
                self?.fetchMeasurements()
            } catch {
                self?.showError("Failed to delete measurement: \(error.localizedDescription)")
            }
        }
    }
    
    // 측정 기록의 상세 정보를 문자열로 반환하는 메서드
    func getMeasurementDetails(_ measurement: SizeRecord) -> String {
        let sizeString = String(format: "%.1f", measurement.size * .pi)
        let typeString = measurement.type == SizeRecord.MeasurementType.ring.rawValue ? "반지 직경" : "손가락 둘레"
        return "\(typeString): \(sizeString) mm"
    }
    
    // 예상 반지 사이즈를 계산하는 메서드
    func getEstimatedRingSize(_ measurement: SizeRecord) -> String {
        let diameter: Double
        if measurement.type == SizeRecord.MeasurementType.ring.rawValue {
            diameter = measurement.size
        } else {
            diameter = SizeModel.fingerCircumferenceToRingDiameter(measurement.size)
        }
        return SizeModel.getRingSize(for: diameter)
    }

    // 손가락 둘레를 계산하는 메서드
    func getFingerCircumference(_ measurement: SizeRecord) -> String {
        if measurement.type == SizeRecord.MeasurementType.ring.rawValue {
            return String(format: "%.1f mm", SizeModel.ringDiameterToFingerCircumference(measurement.size))
        } else {
            return String(format: "%.1f mm", measurement.size)
        }
    }
    
    // 에러 메시지를 표시하는 메서드
    private func showError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = message
            self?.showingError = true
        }
    }
}
