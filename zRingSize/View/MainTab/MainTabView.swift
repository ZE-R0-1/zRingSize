//
//  MainView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RingView()
                .tabItem {
                    Label("Ring", systemImage: "circle")
                }
            
            FingerView()
                .tabItem {
                    Label("Finger", systemImage: "hand.thumbsdown.fill")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
