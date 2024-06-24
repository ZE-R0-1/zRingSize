//
//  RingDisplayView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/05/02.
//

import SwiftUI

struct RingDisplayView: View {
    @ObservedObject var viewModel: RingViewModel
    var ringDiameter: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .frame(width: ringDiameter, height: ringDiameter)
                .overlay {
                    Text(viewModel.filteredItems.first ?? "")
                }
        }
    }
}
