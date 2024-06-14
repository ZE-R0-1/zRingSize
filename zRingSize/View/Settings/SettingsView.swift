//
//  SettingsView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import StoreKit
import MessageUI

struct SettingsView: View {
    @AppStorage("vibrationEnabled") private var isVibrationEnabled = true
    @State private var isMailViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("진동")) {
                        Toggle("진동 허용", isOn: $isVibrationEnabled)
                    }
                    
                    Section(header: Text("앱 정보")) {
                        NavigationLink("도움말", destination: WebView(url: Page.Help.rawValue))
                        NavigationLink("개인정보 정책", destination: WebView(url: Page.Policy.rawValue))
                        NavigationLink("반지 기준 표", destination: SizeChartView())
                    }
                    
                    Section(header: Text("피드백")) {
                        Button(action: {
                            requestReview()
                        }) {
                            Text("리뷰 남기기")
                                .foregroundColor(.primary)
                        }
                        Button(action: {
                            isMailViewPresented.toggle()
                        }) {
                            Text("문의사항 보내기")
                                .foregroundColor(.primary)
                        }
                        .sheet(isPresented: $isMailViewPresented) {
                            EmailSender()
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("설정")
                Spacer()
            }
        }
    }
    
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

enum Page: String {
    case Help = "https://velog.io/@ze-r0/%EB%B0%98%EC%A7%80%EC%B8%A1%EC%A0%95%ED%95%98%EA%B8%B0"
    case Policy = "https://velog.io/@ze-r0/iOS-%EC%95%B1-%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4-%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A8"
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
