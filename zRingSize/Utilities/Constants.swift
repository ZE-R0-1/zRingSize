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
    static let minFingerWidth: Double = 41.15
    static let maxFingerWidth: Double = 70.69

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
    static let maxRecentMeasurements = 5
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
