//
//  Constants.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

enum Constants {
    static let minRingDiameter: Double = 13.1
    static let maxRingDiameter: Double = 22.5
    static let minFingerWidth: Double = 13.1
    static let maxFingerWidth: Double = 22.5

    static let primaryColor = Color(hex: "#4A90E2")
    static let secondaryColor = Color(hex: "#F5A623")
    static let accentColor = Color(hex: "#50E3C2")
    static let backgroundColor = Color(hex: "#F8F8F8")
    static let darkBackgroundColor = Color(hex: "#2C3E50")

    static let cornerRadius: CGFloat = 16
    static let largecornerRadius: CGFloat = 25
    static let padding: CGFloat = 20
    static let shadowRadius: CGFloat = 10
    static let shadowColor = Color.black.opacity(0.1)

    static let gradientColors = [Color(hex: "#4A90E2"), Color(hex: "#50E3C2")]

    // 애니메이션 관련 상수
    static let defaultAnimationDuration: Double = 0.3
    
    // 문자열 상수
    static let appName = "반지 측정하기"
    static let ringMeasurementTitle = "반지 측정"
    static let fingerMeasurementTitle = "손가락 측정"
    static let historyTitle = "측정 기록"
    static let settingsTitle = "설정"
    
    // 기타 상수
//    static let maxRecentMeasurements = 5
}
