//
//  MeasurementGridView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct MeasurementGridView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var showingAddMeasurement: Bool
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            measurementButton(title: "반지 측정", icon: "circle", tab: .ring)
            measurementButton(title: "손가락 측정", icon: "hand.point.up.fill", tab: .finger)
        }
    }
    
    private func measurementButton(title: String, icon: String, tab: Tab) -> some View {
        Button(action: {
            viewModel.changeTab(to: tab)
            showingAddMeasurement = true
        }) {
            VStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: Constants.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(Constants.largecornerRadius)
            .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
        }
    }
}


struct MeasurementGridView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementGridView(showingAddMeasurement: .constant(false))
            .environmentObject(HomeViewModel())
            .previewLayout(.sizeThatFits)
    }
}
