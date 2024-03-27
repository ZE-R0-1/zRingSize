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
                        RingView(viewModel: RingViewModel())
                    case .finger:
                        FingerView()
                    case .history:
                        HistoryView()
                    case .settings:
                        SettingsView()
                    }
                }
                .tabItem {
                    Label(tab.title, image: tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
