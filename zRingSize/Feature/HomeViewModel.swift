//
//  HomeViewModel.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(
        selectedTab: Tab = .ring
    ) {
        self.selectedTab = selectedTab
    }
}

extension HomeViewModel {
    func changeSelected(_ tab: Tab) {
        selectedTab = tab
    }
}
