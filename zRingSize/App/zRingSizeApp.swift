//
//  zRingSizeApp.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

@main
struct ZRingSizeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    requestTrackingAuthorization()
                }
        }
    }
    
    init() {
        setupGoogleMobileAds()
    }
    
    private func setupGoogleMobileAds() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    private func requestTrackingAuthorization() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("추적 권한이 승인되었습니다.")
                case .denied:
                    print("추적 권한이 거부되었습니다.")
                case .restricted:
                    print("추적 기능이 제한되었습니다.")
                case .notDetermined:
                    print("추적 권한이 아직 결정되지 않았습니다.")
                @unknown default:
                    print("알 수 없는 추적 권한 상태입니다.")
                }
            }
        }
    }
}

enum Tab {
    case ring, finger, settings
}
