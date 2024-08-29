//
//  HistoryItemView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct MeasurementDetailView: View {
    let measurement: SizeRecord
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                MeasurementGuideView(size: measurement.size / 10, type: SizeRecord.MeasurementType(rawValue: measurement.type) ?? .ring)
                    .frame(height: 200)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    detailRow(title: "측정 유형", value: measurement.type == SizeRecord.MeasurementType.ring.rawValue ? "반지" : "손가락")
                    detailRow(title: "크기", value: String(format: "%.1f mm", measurement.size))
                    detailRow(title: "예상 반지 사이즈", value: viewModel.getMeasurementDetails(measurement))
                    detailRow(title: "측정 일시", value: measurement.date.formattedString())
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(Constants.cornerRadius)
                .shadow(radius: 2)
            }
            .padding()
        }
        .navigationTitle(measurement.title)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
    
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
        }
    }
}

struct MeasurementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeasurementDetailView(measurement: SizeRecord(title: "내 반지", size: 16.5, type: .finger))
        }
    }
}
