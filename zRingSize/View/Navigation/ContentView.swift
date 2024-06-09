//
//  ContentView.swift
//  zRingSize
//
//  Created by zero on 6/4/24.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .ring
    
    var body: some View {
        VStack(spacing: 20) {
            switch selectedTab {
            case .ring:
                RingView()
            case .finger:
                FingerView()
//            case .map:
//                Text("Map")
            case .history:
                HistoryView()
            case .setting:
                SettingsView()
            }
            GoogleAdView()
                .frame(width: UIScreen.main.bounds.width, height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
            TabBar()
        }
    }
}

#Preview {
    ContentView()
}
