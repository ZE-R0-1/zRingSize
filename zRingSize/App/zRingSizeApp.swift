//
//  zRingSizeApp.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import GoogleMobileAds
import AdSupport
import AppTrackingTransparency

@main
struct zRingSizeApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
                }
        }
    }
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // DispatchQueue 이용
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
        }
        Util.share.copyDatabase(dbName: "zRingSize.db")
    }
}

