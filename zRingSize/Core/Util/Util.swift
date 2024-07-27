//
//  Util.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import Foundation
import UIKit

class Util {
    
    static let share = Util()
    
    // MARK: - 데이터베이스 경로 가져오기
    
    func getPath(dbName: String) -> String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent(dbName)
        print(fileUrl.path)
        return fileUrl.path
    }
    
    // MARK: - 데이터베이스 경로가 없으면 경로 생성하기
    func copyDatabase(dbName: String) {
        let dbPath = getPath(dbName: "zRingSize.db")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath) {
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(dbName)
            do {
                try fileManager.copyItem(atPath: file!.path, toPath: dbPath)
            }
            catch let err {
                print(err.localizedDescription)
            }
        }
    }
}
