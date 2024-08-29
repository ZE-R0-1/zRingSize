//
//  MeasurementService.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import Foundation
import RealmSwift

// 측정 데이터를 관리하는 서비스 클래스
class MeasurementService {
    // 싱글톤 인스턴스
    static let shared = MeasurementService()
    
    // Realm 데이터베이스 인스턴스
    private var realm: Realm
    
    // 프라이빗 초기화 메서드
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    // 새로운 측정 데이터를 저장하는 메서드
    func saveMeasurement(title: String, size: Double, type: SizeRecord.MeasurementType) throws {
        let newMeasurement = SizeRecord()
        newMeasurement.title = title
        newMeasurement.size = size
        newMeasurement.type = type.rawValue
        newMeasurement.date = Date()
        
        do {
            try realm.write {
                realm.add(newMeasurement)
            }
        } catch {
            throw error
        }
    }
    
    // 모든 측정 데이터를 가져오는 메서드
    func getMeasurements() -> [SizeRecord] {
        return Array(realm.objects(SizeRecord.self).sorted(byKeyPath: "date", ascending: false))
    }
    
    // 최근 측정 데이터를 제한된 수만큼 가져오는 메서드
    func getRecentMeasurements(limit: Int) -> [SizeRecord] {
        return Array(realm.objects(SizeRecord.self).sorted(byKeyPath: "date", ascending: false).prefix(limit))
    }
    
    // 특정 ID의 측정 데이터를 삭제하는 메서드
    func deleteMeasurement(id: UUID) {
        if let measurementToDelete = realm.object(ofType: SizeRecord.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    realm.delete(measurementToDelete)
                }
            } catch {
                print("Error deleting measurement: \(error)")
            }
        }
    }
}
