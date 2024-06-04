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
                Text("Ring")
            case .finger:
                Text("Finger")
            case .map:
                Text("Map")
            case .history:
                Text("History")
            case .setting:
                Text("Setting")
            }
            TabBar()
        }
    }
}

#Preview {
    ContentView()
}
