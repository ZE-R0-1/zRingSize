//
//  UserModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import RealmSwift

class SizeRecord: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var title: String = ""
    @Persisted var size: Double = 0.0
    @Persisted var date: Date = Date()
    @Persisted var type: String = ""
    
    convenience init(title: String, size: Double, type: MeasurementType) {
        self.init()
        self.title = title
        self.size = size
        self.type = type.rawValue
    }
    
    enum MeasurementType: String {
        case ring
        case finger
    }
}
