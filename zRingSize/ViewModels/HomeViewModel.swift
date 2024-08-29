//
//  HomeViewModel.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import Combine
import RealmSwift
import Foundation

// 홈 화면을 위한 ViewModel
class HomeViewModel: ObservableObject {
    // 현재 선택된 탭 (반지 또는 손가락)
    @Published var selectedTab: Tab = .ring
    
    // 새 측정 추가 화면 표시 여부
    @Published var showingAddMeasurement = false
    
    // 측정 기록 관리를 위한 HistoryViewModel
    let historyViewModel: HistoryViewModel
    
    // 초기화 메서드
    init(historyViewModel: HistoryViewModel = HistoryViewModel()) {
        self.historyViewModel = historyViewModel
    }
    
    // 탭 변경 메서드
    func changeTab(to tab: Tab) {
        self.selectedTab = tab
    }
}
