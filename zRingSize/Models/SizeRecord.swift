//
//  UserModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import RealmSwift
import Foundation

class SizeRecord: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()  // 고유 식별자, 기본 키로 사용
    @Persisted var title: String = ""  // 측정 기록의 제목
    @Persisted var size: Double = 0.0  // 측정된 크기 값
    @Persisted var date: Date = Date()  // 측정 날짜, 기본값은 현재 날짜
    @Persisted var type: String = ""  // 측정 유형 (반지 또는 손가락)
    
    // 편의 생성자: 새로운 SizeRecord 객체를 쉽게 생성할 수 있게 해줌
    convenience init(title: String, size: Double, type: MeasurementType) {
        self.init()
        self.title = title
        self.size = size
        self.type = type.rawValue  // enum의 rawValue를 저장
    }
    
    // 측정 유형을 나타내는 열거형
    enum MeasurementType: String {
        case ring    // 반지 측정
        case finger  // 손가락 측정
    }
}
