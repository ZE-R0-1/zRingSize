//
//  HomeView.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import SwiftUI

// 앱의 메인 홈 화면을 나타내는 View
struct HomeView: View {
    // HomeViewModel 인스턴스 생성
    @StateObject private var viewModel = HomeViewModel()
    // HistoryViewModel 인스턴스 생성
    @StateObject private var historyViewModel = HistoryViewModel()
    // 측정 추가 화면 표시 여부를 관리하는 상태 변수
    @State private var showingAddMeasurement = false

    var body: some View {
        NavigationView {
            ZStack {
                // 배경색 설정
                Constants.backgroundColor.edgesIgnoringSafeArea(.all)

                VStack(spacing: Constants.padding) {
                    // 측정 그리드 뷰
                    MeasurementGridView(showingAddMeasurement: $showingAddMeasurement)
                        .environmentObject(viewModel)
                    // 측정 기록 뷰
                    HistoryView()
                        .environmentObject(historyViewModel)
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(Constants.appName)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: settingsButton)
            // 측정 추가 화면 표시
            .sheet(isPresented: $showingAddMeasurement) {
                if viewModel.selectedTab == .ring {
                    RingView()
                } else {
                    FingerView()
                }
            }
            // 오류 알림 표시
            .alert(isPresented: $historyViewModel.showingError) {
                Alert(title: Text("오류"),
                      message: Text(historyViewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."),
                      dismissButton: .default(Text("확인")))
            }
        }
    }

    // 설정 버튼
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
