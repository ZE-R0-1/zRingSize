//
//  ContentView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = RingSizerViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            RingSizeTab(viewModel: viewModel)
                .tabItem {
                    Label("링 사이즈", systemImage: "1.circle")
                }
            
            FingerThicknessTab(fingerThickness: $viewModel.fingerThickness, viewModel: viewModel, context: viewContext)
                .tabItem {
                    Label("손가락 두께", systemImage: "2.circle")
                }
            
            SavedSizesTab(savedSizes: $viewModel.savedSizes, viewModel: viewModel, context: viewContext)
                .tabItem {
                    Label("저장된 사이즈", systemImage: "3.circle")
                }
            
            SettingsTab()
                .tabItem {
                    Label("설정", systemImage: "4.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
