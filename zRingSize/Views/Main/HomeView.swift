//
//  HomeView.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var appState: AppState
    @State private var showingAddMeasurement = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Constants.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: Constants.padding) {
                    MeasurementGridView(showingAddMeasurement: $showingAddMeasurement)
                        .environmentObject(viewModel)
                    
                    RecentMeasurementsView(measurements: viewModel.recentMeasurements)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(Constants.appName)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: settingsButton)
            .sheet(isPresented: $showingAddMeasurement) {
                if viewModel.selectedTab == .ring {
                    RingView()
                } else {
                    FingerView()
                }
            }
            .alert(isPresented: $viewModel.showingError) {
                Alert(title: Text("오류"), message: Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."), dismissButton: .default(Text("확인")))
            }
        }
    }
    
    private var settingsButton: some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(Constants.primaryColor)
                .font(.system(size: 22))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
