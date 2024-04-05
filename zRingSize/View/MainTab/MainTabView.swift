//
//  MainTabView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: MainTabType = .ring
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Group {
                    switch tab {
                    case .ring:
                        RingView()
                    case .finger:
                        FingerView(viewModel: FingerViewModel())
                    case .history:
                        HistoryView()
                    case .settings:
                        SettingsView()
                    }
                }
                .tabItem {
                    Image(systemName: tab.systemImageName)
                    Text(tab.title)
                }
                .tag(tab)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
