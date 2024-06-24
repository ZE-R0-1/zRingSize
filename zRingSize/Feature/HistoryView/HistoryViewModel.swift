//
//  HistoryViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/24.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var items: [SizeRecord] = []

    func fetchRecords() {
        items = ModelManager.getInstance().getAllrecord().reversed()
    }

    func deleteRecord(at index: Int) {
        let recordToDelete = items[index]
        if ModelManager.getInstance().deleteRecord(record: recordToDelete) {
            items.remove(at: index)
        } else {
            // 삭제 실패 처리
            print("데이터 삭제에 실패했습니다.")
        }
    }
}
