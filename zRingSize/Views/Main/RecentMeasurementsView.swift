//
//  RecentMeasurementsView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct RecentMeasurementsView: View {
    let measurements: [SizeRecord]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("최근 측정")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            if measurements.isEmpty {
                Text("최근 측정 기록이 없습니다.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(measurements) { measurement in
                    NavigationLink(destination: MeasurementDetailView(measurement: measurement)) {
                        MeasurementRowView(measurement: measurement)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Constants.cornerRadius)
        .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
    }
}

struct RecentMeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentMeasurementsView(measurements: [
            SizeRecord(title: "내 반지", size: 16.5, type: .ring),
            SizeRecord(title: "엄지 손가락", size: 23.0, type: .finger)
        ])
        .previewLayout(.sizeThatFits)
    }
}
