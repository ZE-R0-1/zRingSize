//
//  SettingsView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

// 설정 화면을 나타내는 View
struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    // 설정 초기화 알림 표시 여부
    @State private var showingResetAlert = false
    @State private var isShowingMailView = false
    
    var body: some View {
        Form {
            // 일반 설정 섹션
            Section(header: Text("일반")) {
                // 진동 설정
                SettingsItemView(title: "진동 허용") {
                    Toggle("", isOn: $viewModel.isVibrationEnabled)
                }
            }
            
            // 정보 섹션
            Section(header: Text("정보")) {
                NavigationLink("반지 사이즈 차트", destination: SizeChartView())
                NavigationLink("도움말", destination: WebView(url: Page.Help.rawValue))
                NavigationLink("개인정보 처리방침", destination: WebView(url: Page.Policy.rawValue))
            }
            
            Section(header: Text("피드백")) {
                Button("오류 신고 / 피드백 보내기") {
                    isShowingMailView = true
                }
            }
            
            // 앱 정보 섹션
            Section(header: Text("앱 정보")) {
                SettingsItemView(title: "버전") {
                    Text(viewModel.appVersion)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("설정")
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: $isShowingMailView, result: { result in
                switch result {
                case .success:
                    print("Email sent successfully")
                case .failure(let error):
                    print("Failed to send email with error:", error)
                }
            })
        }
    }
}

// 웹 페이지 URL 열거형

enum Page: String {
    case Help = "https://velog.io/@ze-r0/%EB%B0%98%EC%A7%80%EC%B8%A1%EC%A0%95%ED%95%98%EA%B8%B0"
    case Policy = "https://velog.io/@ze-r0/iOS-%EC%95%B1-%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4-%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A8"
}

// 미리보기 제공자
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
