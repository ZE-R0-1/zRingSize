//
//  SettingsView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                // 진동 섹션 추가
                Section(header: Text("진동")) {
                    Toggle("진동 허용", isOn: .constant(true))
                }
                
                Section(header: Text("도움말")) {
                    NavigationLink(destination: HelpView()) {
                        Text("도움말 및 지원")
                    }
                    NavigationLink(destination: AboutView()) {
                        Text("앱 정보")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("설정")
        }
    }
}

struct HelpView: View {
    var body: some View {
        Text("도움말 및 지원")
            .navigationBarTitle("도움말")
    }
}

struct AboutView: View {
    var body: some View {
        Text("앱 정보")
            .navigationBarTitle("앱 정보")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
