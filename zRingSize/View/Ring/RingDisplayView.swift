//
//  RingDisplayView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/03.
//

import SwiftUI

struct RingDisplayView: View {
    let ringDiameter: CGFloat
    let calibrationWidth: CGFloat = 4.57
    let geometry: GeometryProxy
    let ringSize: String
    
    var body: some View {
        let diameterInPoints = self.calculateDiameterInPoints(sizeInCentimeters: self.ringDiameter, calibrationWidth: self.calibrationWidth)
        
        return Circle()
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
            .frame(width: diameterInPoints, height: diameterInPoints)
            .position(x: self.geometry.size.width / 2, y: self.geometry.size.height / 2)
            .overlay {
                Text(self.ringSize)
                    .bold()
            }
    }
    
    private func calculateDiameterInPoints(sizeInCentimeters: CGFloat, calibrationWidth: CGFloat) -> CGFloat {
        let conversionFactor = calibrationWidth / self.geometry.size.width
        return sizeInCentimeters / conversionFactor
    }
}

