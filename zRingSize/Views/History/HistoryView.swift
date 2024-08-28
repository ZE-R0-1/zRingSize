//
//  HistoryView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isDeleteMode = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("측정 기록")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    isDeleteMode.toggle()
                }) {
                    Image(systemName: isDeleteMode ? "checkmark.circle.fill" : "trash")
                        .foregroundColor(isDeleteMode ? .green : .red)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal)
            
            if viewModel.recentMeasurements.isEmpty {
                Text("최근 측정 기록이 없습니다.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(viewModel.recentMeasurements) { measurement in
                    MeasurementRowView(measurement: measurement, isDeleteMode: $isDeleteMode, onDelete: {
                        viewModel.deleteMeasurement(id: measurement.id)
                    })
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Constants.cornerRadius)
        .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: HomeViewModel())
    }
}
