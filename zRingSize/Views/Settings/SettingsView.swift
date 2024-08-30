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
    
    var body: some View {
        Form {
            // 일반 설정 섹션
            Section(header: Text("일반")) {
                // 진동 설정
                SettingsItemView(title: "진동 허용") {
                    Toggle("", isOn: $viewModel.isVibrationEnabled)
                }
                
                // 측정 단위 설정
                SettingsItemView(title: "측정 단위") {
                    Picker("", selection: $viewModel.measurementUnit) {
                        ForEach(SettingsViewModel.MeasurementUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized).tag(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: viewModel.measurementUnit) { newValue in
                        viewModel.changeMeasurementUnit(to: newValue)
                    }
                }
            }
            
            // 정보 섹션
            Section(header: Text("정보")) {
                NavigationLink("반지 사이즈 차트", destination: SizeChartView())
                NavigationLink("도움말", destination: WebView(url: Page.Help.rawValue))
                NavigationLink("개인정보 처리방침", destination: WebView(url: Page.Policy.rawValue))
            }
            
            // 앱 정보 섹션
            Section(header: Text("앱 정보")) {
                SettingsItemView(title: "버전") {
                    Text(viewModel.appVersion)
                        .foregroundColor(.secondary)
                }
            }
            
            // 설정 초기화 섹션
            Section {
                Button("모든 설정 초기화") {
                    showingResetAlert = true
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("설정")
        // 설정 초기화 확인 알림
        .alert(isPresented: $showingResetAlert) {
            Alert(
                title: Text("설정 초기화"),
                message: Text("모든 설정을 초기화하시겠습니까?"),
                primaryButton: .destructive(Text("초기화")) {
                    viewModel.resetAllSettings()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

// 웹 페이지 URL 열거형
enum Page: String {
    case Help = "https://www.zringsize.com/help"
    case Policy = "https://www.zringsize.com/privacy-policy"
}

// 미리보기 제공자
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
