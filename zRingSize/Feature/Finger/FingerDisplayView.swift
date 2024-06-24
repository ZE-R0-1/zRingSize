//
//  FingerDisplayView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/04.
//

import SwiftUI

struct FingerDisplayView: View {
    let fingerWidth: CGFloat
    
    var body: some View {
        Rectangle()
            .stroke(style: StrokeStyle(lineWidth: 3, dash: [5]))
            .frame(width: fingerWidth, height: 300)
            .cornerRadius(5)
    }
}
