//
//  ModelManager.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import Foundation
import UIKit

var shareInstance = ModelManager()

class ModelManager {
    var database: FMDatabase? = nil
    
    static func getInstance() -> ModelManager {
        if shareInstance.database == nil {
            shareInstance.database = FMDatabase(path: Util.share.getPath(dbName: "zRingSize.db"))
        }
        return shareInstance
    }
    
    func SaveRecord(record: SizeRecord) -> Bool {
        shareInstance.database?.open()
        let isSave = shareInstance.database?.executeUpdate("INSERT INTO sizer (title, size, date) VALUEs (?, ?, ?)", withArgumentsIn: [record.title, record.size, record.date])
        
        shareInstance.database?.close()
        return isSave!
    }
    
    func getAllrecord() -> [SizeRecord] {
        shareInstance.database?.open()
        var records = [SizeRecord]()
        do {
            let resultset: FMResultSet? = try shareInstance.database?.executeQuery("SELECT * FROM sizer", values: nil)
            if resultset != nil {
                while resultset!.next() {
                    let record = SizeRecord(id: Int32(Int((resultset!.int(forColumn: "id")))),
                                            title: (resultset!.string(forColumn: "title")!),
                                            size: (resultset!.string(forColumn: "size")!),
                                            date: (resultset!.string(forColumn: "date")!))
                    records.append(record)
                }
            }
        }
        catch let err {
            print(err.localizedDescription)
        }
        shareInstance.database?.close()
        return records
    }
    
    func updateRecord(record: SizeRecord) -> Bool {
        shareInstance.database?.open()
        
        let isUpdate = shareInstance.database?.executeUpdate("UPDATE sizer SET title=?, size=?, date=? WHERE id=?", withArgumentsIn: [record.title, record.size, record.date])
        
        shareInstance.database?.close()
        return isUpdate!
    }
    
    func deleteRecord(record: SizeRecord) -> Bool {
        shareInstance.database?.open()
        
        let isDeleted = shareInstance.database?.executeUpdate("DELETE FROM sizer where title=?", withArgumentsIn: [record.title])
        
        shareInstance.database?.close()
        return isDeleted!
    }
}
