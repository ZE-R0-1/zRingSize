//
//  ContentView.swift
//  zRingSize
//
//  Created by zero on 6/4/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .ring
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .ring:
                RingView()
            case .finger:
                FingerView()
            case .map:
                Text("Map")
            case .history:
                HistoryView()
            case .setting:
                SettingsView()
            }
            TabBar()
        }
    }
}

#Preview {
    ContentView()
}
