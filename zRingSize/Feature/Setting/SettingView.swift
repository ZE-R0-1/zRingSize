//  SettingView.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import SwiftUI
import MessageUI

struct SettingView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showingEmailSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView()
                Spacer()
                    .frame(height: 35)
                TotalView(showingEmailSheet: $showingEmailSheet)
                Spacer()
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingEmailSheet) {
                if MFMailComposeViewController.canSendMail() {
                    EmailSender()
                } else {
                    Text("이메일을 보낼 수 없습니다. 이메일 계정을 확인해주세요.")
                }
            }
        }
    }
}

// MARK: - 전체 뷰
private struct TotalView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @AppStorage("vibrationEnabled") private var isVibrationEnabled = true
    @Binding var showingEmailSheet: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
            
            ToggleView(
                title: "진동 허용",
                isOn: $isVibrationEnabled
            )
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
            
            LinkMoveView(
                title: "도움말",
                destination: WebView(url: Page.Help.rawValue)
                    .navigationTitle("도움말")
            )
            
            LinkMoveView(
                title: "개인정보 정책",
                destination: WebView(url: Page.Policy.rawValue)
                    .navigationTitle("개인정보 정책")
            )
            
            LinkMoveView(
                title: "반지 기준 표",
                destination: SizeChartView()
                    .navigationTitle("반지 기준 표")
            )
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
            
            Button(action: {
                showingEmailSheet = true
            }) {
                HStack {
                    Text("문의사항 보내기")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .padding(.all, 20)
            }
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
        }
    }
}

// MARK: - 네비게이션 뷰
private struct LinkMoveView<Destination: View>: View {
    private var title: String
    private var destination: Destination
    
    fileprivate init(
        title: String,
        destination: Destination
    ) {
        self.title = title
        self.destination = destination
    }
    
    fileprivate var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                HStack {
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .padding(.all, 20)
            }
        )
    }
}

// MARK: - 토글 뷰
private struct ToggleView: View {
    var title: String
    @Binding var isOn: Bool
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
            }
            .padding(.all, 20)
        }
    }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("설정")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 45)
    }
}

enum Page: String {
    case Help = "https://velog.io/@ze-r0/%EB%B0%98%EC%A7%80%EC%B8%A1%EC%A0%95%ED%95%98%EA%B8%B0"
    case Policy = "https://velog.io/@ze-r0/iOS-%EC%95%B1-%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4-%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A8"
}

#Preview {
    SettingView()
        .environmentObject(HomeViewModel())
}
