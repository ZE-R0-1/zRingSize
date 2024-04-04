//
//  FingerDisplayView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/04.
//

import SwiftUI

struct FingerDisplayView: View {
    let fingerWidth: CGFloat
    let calibrationWidth: CGFloat = 4.57
    let geometry: GeometryProxy
    
    var body: some View {
        let widthInPoints = self.calculateWidthInPoints(widthInCentimeters: self.fingerWidth, calibrationWidth: self.calibrationWidth)
        
        return Rectangle()
            .stroke(style: StrokeStyle(lineWidth: 3, dash: [5]))
            .frame(width: widthInPoints, height: 400)
            .cornerRadius(5)
            .position(x: self.geometry.size.width / 2, y: self.geometry.size.height / 2)
    }
    
    private func calculateWidthInPoints(widthInCentimeters: CGFloat, calibrationWidth: CGFloat) -> CGFloat {
        let conversionFactor = calibrationWidth / self.geometry.size.width
        return widthInCentimeters / conversionFactor
    }
    
}
