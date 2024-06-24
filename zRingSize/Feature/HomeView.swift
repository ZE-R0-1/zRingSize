//
//  HomeView.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import SwiftUI
import GoogleMobileAds

struct HomeView: View {
    @EnvironmentObject private var pathModel: PathModel
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $homeViewModel.selectedTab) {
                RingView()
                    .tabItem {
                        Image(systemName:
                                homeViewModel.selectedTab == .ring
                              ? "ring.circle.fill"
                              : "ring.circle"
                        )
                    }
                    .tag(Tab.ring)
                
                FingerView()
                    .tabItem {
                        Image(systemName:
                                homeViewModel.selectedTab == .finger
                              ? "hand.point.up.fill"
                              : "hand.point.up"
                        )
                    }
                    .tag(Tab.finger)
                
                HistoryView()
                    .tabItem {
                        Image(systemName:
                                homeViewModel.selectedTab == .history
                              ? "list.bullet.circle.fill"
                              : "list.bullet.circle"
                        )
                    }
                    .tag(Tab.history)
                
                SettingView()
                    .tabItem {
                        Image(systemName:
                                homeViewModel.selectedTab == .setting
                              ? "gearshape.fill"
                              : "gearshape"
                        )
                    }
                    .tag(Tab.setting)
            }
            .environmentObject(homeViewModel)
            SeperatorLineView()
        }
    }
}

// MARK: - 구분선
private struct SeperatorLineView: View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 10)
                .padding(.bottom, 60)
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(PathModel())
}
