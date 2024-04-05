//
//  MainTabType.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import Foundation

enum MainTabType: String, CaseIterable {
    case ring
    case finger
    case history
    case settings
    
    var title: String {
        switch self {
        case .ring:
            return "반지"
        case .finger:
            return "손가락"
        case .history:
            return "기록"
        case .settings:
            return "설정"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .ring:
            return "ring.circle"
        case .finger:
            return "hand.point.up"
        case .history:
            return "list.bullet.circle"
        case .settings:
            return "gearshape"
        }
    }
}
