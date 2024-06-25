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

    func deleteRecord(at indexSet: IndexSet) {
        let modelManager = ModelManager.getInstance()
        indexSet.forEach { index in
            let recordToDelete = items[index]
            if modelManager.deleteRecord(record: recordToDelete) {
                items.remove(at: index)
            } else {
                print("데이터 삭제에 실패했습니다.")
            }
        }
    }
}
