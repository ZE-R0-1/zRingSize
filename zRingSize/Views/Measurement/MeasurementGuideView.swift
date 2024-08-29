//
//  MeasurementGuideView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct MeasurementGuideView: View {
    let size: Double
    let type: SizeRecord.MeasurementType
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                    .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
                
                if type == .ring {
                    Circle()
                        .stroke(
                            LinearGradient(gradient: Gradient(colors: Constants.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing),
                            lineWidth: 4
                        )
                        .frame(width: CGFloat(size * onecentimeter), height: CGFloat(size * onecentimeter))
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .blendMode(.overlay)
                        )
                        .shadow(color: Constants.shadowColor, radius: 5, x: 0, y: 2)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(gradient: Gradient(colors: Constants.gradientColors), startPoint: .top, endPoint: .bottom),
                            lineWidth: 4
                        )
                        .frame(width: CGFloat(size * onecentimeter), height: geometry.size.height * 0.8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2)
                                .blendMode(.overlay)
                        )
                        .shadow(color: Constants.shadowColor, radius: 5, x: 0, y: 2)
                }
                
                VStack {
                    Text(type == .ring ? "반지" : "손가락")
                        .font(.headline)
                        .foregroundColor(Constants.primaryColor)
                    
                    if type == .finger {
                        Image(systemName: "hand.point.up.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Constants.primaryColor)
                            .shadow(color: Constants.shadowColor, radius: 2, x: 0, y: 1)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    public var onecentimeter: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let nativeWidth = UIScreen.main.nativeBounds.width
        let nativeHeight = UIScreen.main.nativeBounds.height
        let screenDiagonal = CGFloat(hypot(screenWidth, screenHeight)) // 대각선 길이 (포인트 단위)
        let screenInches = DeviceInfo.screenSize(forWidth: nativeWidth, height: nativeHeight)! // 실제 화면 크기 (인치 단위)
        let pointsPerInch = screenDiagonal / screenInches // 1인치당 포인트 수
        return CGFloat(pointsPerInch / 2.54) // 1cm 길이 (포인트 단위)
    }
}

struct MeasurementGuideView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MeasurementGuideView(size: 1, type: .ring)
            MeasurementGuideView(size: 1, type: .finger)
        }
    }
}
