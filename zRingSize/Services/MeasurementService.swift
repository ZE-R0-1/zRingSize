//
//  MeasurementService.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import Foundation
import RealmSwift

class MeasurementService {
    static let shared = MeasurementService()
    private var realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
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
    
    func getMeasurements() -> [SizeRecord] {
        return Array(realm.objects(SizeRecord.self).sorted(byKeyPath: "date", ascending: false))
    }
    
    func getRecentMeasurements(limit: Int) -> [SizeRecord] {
        return Array(realm.objects(SizeRecord.self).sorted(byKeyPath: "date", ascending: false).prefix(limit))
    }
    
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
    
    func calculateRingSize(diameter: Double) -> String {
        // 여기에 반지 사이즈 계산 로직을 구현합니다.
        // 이 예시에서는 간단히 직경을 문자열로 반환합니다.
        return String(format: "%.1f", diameter)
    }
    
    func convertFingerToRingSize(fingerWidth: Double) -> String {
        // 여기에 손가락 너비를 반지 사이즈로 변환하는 로직을 구현합니다.
        // 이 예시에서는 간단히 너비를 문자열로 반환합니다.
        return String(format: "%.1f", fingerWidth)
    }
}

