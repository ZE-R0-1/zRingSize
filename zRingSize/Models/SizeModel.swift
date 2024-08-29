//
//  SizeModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/03.
//

import UIKit

struct SizeModel {
    // 반지 사이즈 차트 (한국 기준)
    static let ringSizes: [String: Double] = [
        "1호": 13.1,
        "2호": 13.6,
        "3호": 13.8,
        "4호": 14.2,
        "5호": 14.5,
        "6호": 14.7,
        "7호": 15.0,
        "8호": 15.4,
        "9호": 15.8,
        "10호": 16.0,
        "11호": 16.4,
        "12호": 16.6,
        "13호": 17.0,
        "14호": 17.2,
        "15호": 17.7,
        "16호": 18.0,
        "17호": 18.3,
        "18호": 18.6,
        "19호": 19.0,
        "20호": 19.3,
        "21호": 19.6,
        "22호": 19.8,
        "23호": 20.1,
        "24호": 20.5,
        "25호": 20.8,
        "26호": 21.1,
        "27호": 21.5,
        "28호": 21.8,
        "29호": 22.1,
        "30호": 22.5
    ]
    
    // 직경을 받아 가장 가까운 반지 사이즈를 반환하는 메서드
    static func getRingSize(for diameter: Double) -> String {
        let closestSize = ringSizes.min { abs($0.value - diameter) < abs($1.value - diameter) }
        return closestSize?.key ?? "Unknown"
    }
    
    // 손가락 둘레를 반지 직경으로 변환하는 메서드
    static func fingerCircumferenceToRingDiameter(_ circumference: Double) -> Double {
        return circumference / .pi
    }
    
    // 반지 직경을 손가락 둘레로 변환하는 메서드
    static func ringDiameterToFingerCircumference(_ diameter: Double) -> Double {
        return diameter * .pi
    }
}
