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



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
