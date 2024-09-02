//
//  HomeView.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import SwiftUI
import GoogleMobileAds

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var historyViewModel = HistoryViewModel()
    @State private var showingAddMeasurement = false
    @State private var adLoaded = true

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: Constants.padding) {
                    MeasurementGridView(showingAddMeasurement: $showingAddMeasurement)
                        .environmentObject(viewModel)
                    HistoryView()
                        .environmentObject(historyViewModel)
                    Spacer()
                }
                .padding()
                .background(Constants.backgroundColor.edgesIgnoringSafeArea(.all))

                // 광고 뷰 추가
                VStack {
                    GoogleAdView(adLoaded: $adLoaded)
                        .frame(height: 50)  // 광고의 높이에 맞게 조정
                }
                .padding(.bottom, 40)  // 하단에서 20포인트 떨어지게 설정
            }
            .edgesIgnoringSafeArea(.bottom)  // 하단 SafeArea 무시
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
            .alert(isPresented: $historyViewModel.showingError) {
                Alert(title: Text("오류"),
                      message: Text(historyViewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."),
                      dismissButton: .default(Text("확인")))
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

// 미리보기 제공자
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
