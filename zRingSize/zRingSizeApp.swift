//
//  zRingSizeApp.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

@main
struct zRingSizeApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
    
    init() {
        Util.share.copyDatabase(dbName: "zRingSize.db")
    }
}

