//
//  SettingsView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import GoogleMobileAds

struct SettingsView: View {
    @AppStorage("vibrationEnabled") private var isVibrationEnabled = true
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("진동")) {
                        Toggle("진동 허용", isOn: $isVibrationEnabled)
                    }
                    
                    Section(header: Text("정보")) {
                        NavigationLink("반지 기준 표", destination: SizeChartView())
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("설정")
                Spacer()
                GoogleAdView()
                    .frame(width: UIScreen.main.bounds.width, height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
