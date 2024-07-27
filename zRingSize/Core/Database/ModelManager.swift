//
//  ModelManager.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import Foundation
import UIKit

// ModelManager의 인스턴스를 전역 변수로 선언
var shareInstance = ModelManager()

// ModelManager 클래스 정의
class ModelManager {
    // FMDatabase 타입의 데이터베이스 변수 선언
    var database: FMDatabase? = nil
    // ModelManager의 인스턴스를 반환하는 정적 메서드
    static func getInstance() -> ModelManager {
        // 데이터베이스가 nil인 경우, 데이터베이스를 초기화
        if shareInstance.database == nil {
            shareInstance.database = FMDatabase(path: Util.share.getPath(dbName: "zRingSize.db"))
        }
        return shareInstance
    }
    // 기록을 저장하는 메서드
    func SaveRecord(record: SizeRecord) -> Bool {
        // 데이터베이스 열기
        shareInstance.database?.open()
        // INSERT 쿼리를 실행하여 기록 저장
        let isSave = shareInstance.database?.executeUpdate("INSERT INTO sizer (title, size, date) VALUEs (?, ?, ?)", withArgumentsIn: [record.title, record.size, record.date])
        // 데이터베이스 닫기
        shareInstance.database?.close()
        // 저장 성공 여부 반환
        return isSave!
    }
    
    // 모든 기록을 가져오는 메서드
    func getAllrecord() -> [SizeRecord] {
        // 데이터베이스 열기
        shareInstance.database?.open()
        var records = [SizeRecord]()
        do {
            // SELECT 쿼리를 실행하여 결과 집합 가져오기
            let resultset: FMResultSet? = try shareInstance.database?.executeQuery("SELECT * FROM sizer", values: nil)
            if resultset != nil {
                while resultset!.next() {
                    // 결과 집합에서 데이터를 읽어 SizeRecord 객체 생성 후 배열에 추가
                    let record = SizeRecord(id: Int(resultset!.int(forColumn: "id")),
                                            title: (resultset!.string(forColumn: "title")!),
                                            size: (resultset!.string(forColumn: "size")!),
                                            date: (resultset!.string(forColumn: "date")!))
                    records.append(record)
                }
            }
        }
        catch let err {
            // 에러 발생 시 에러 메시지 출력
            print(err.localizedDescription)
        }
        // 데이터베이스 닫기
        shareInstance.database?.close()
        // 기록 배열 반환
        return records
    }
    
    // 기록을 업데이트하는 메서드
    func updateRecord(record: SizeRecord) -> Bool {
        // 데이터베이스 열기
        shareInstance.database?.open()
        // UPDATE 쿼리를 실행하여 기록 업데이트
        let isUpdate = shareInstance.database?.executeUpdate("UPDATE sizer SET title=?, size=?, date=? WHERE id=?", withArgumentsIn: [record.title, record.size, record.date])
        // 데이터베이스 닫기
        shareInstance.database?.close()
        // 업데이트 성공 여부 반환
        return isUpdate!
    }
    
    // 기록을 삭제하는 메서드
    func deleteRecord(record: SizeRecord) -> Bool {
        // 데이터베이스 열기
        shareInstance.database?.open()
        // DELETE 쿼리를 실행하여 기록 삭제
        let isDeleted = shareInstance.database?.executeUpdate("DELETE FROM sizer where title=?", withArgumentsIn: [record.title])
        // 데이터베이스 닫기
        shareInstance.database?.close()
        // 삭제 성공 여부 반환
        return isDeleted!
    }
}
