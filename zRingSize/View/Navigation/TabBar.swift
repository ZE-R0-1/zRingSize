//
//  TabBar.swift
//  zRingSize
//
//  Created by zero on 6/4/24.
//

import SwiftUI

struct TabBar: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .ring

    var body: some View {
        VStack {
            HStack(spacing: 30) {
                content
            }
            .padding(12)
            .background(Color("Background 2").opacity(0.8))
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: Color("Background 2").opacity(0.3), radius: 20, x: 0, y: 20)
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(.linearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .padding(.horizontal, 24)
        }
    }

    var content: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation {
                    selectedTab = item.tab
                }
            } label: {
                VStack {
                    Image(systemName: item.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 28.8)
                        .foregroundColor(.white)
                        .opacity(selectedTab == item.tab ? 1 : 0.5)
                    
                    Text(item.name)
                        .font(.caption)
                        .foregroundColor(.white)
                        .opacity(selectedTab == item.tab ? 1 : 0.5)
                }
                .background(
                    VStack {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.accentColor)
                            .frame(width: selectedTab == item.tab ? 18 : 0, height: 3.2)
                            .offset(y: -3.2)
                            .opacity(selectedTab == item.tab ? 1 : 0)
                        Spacer()
                    }
                )
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    TabBar()
}

struct TabItem: Identifiable {
    var id = UUID()
    var icon: String
    var name: String
    var tab: Tab
}

var tabItems = [
    TabItem(icon: "ring.circle", name: "반지", tab: .ring),
    TabItem(icon: "hand.point.up", name: "손가락", tab: .finger),
    TabItem(icon: "list.bullet.circle", name: "기록", tab: .history),
//    TabItem(icon: "map", name: "지도", tab: .map),
    TabItem(icon: "gearshape", name: "설정", tab: .setting)
]

enum Tab: String {
    case ring
    case finger
//    case map
    case history
    case setting
}
