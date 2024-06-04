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
            MainTabView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
                }
        }
    }
    
    init() {
//        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "689153a9052494c1c60c1f1defcdc4fe" ]
        
        // DispatchQueue 이용
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
        }
        Util.share.copyDatabase(dbName: "zRingSize.db")
    }
}

