//
//  HistoryView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var viewModel: HistoryViewModel
    @State private var isDeleteMode = false
    @State private var contentHeight: CGFloat = .zero

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                // 상단 헤더 부분
                HStack {
                    Text("측정 기록")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        isDeleteMode.toggle()
                    }) {
                        Image(systemName: isDeleteMode ? "chevron.right" : "trash")
                            .foregroundColor(isDeleteMode ? .green : .red)
                            .font(.system(size: 20))
                    }
                }
                .padding(.horizontal)

                if viewModel.allMeasurements.isEmpty {
                    Text("측정 기록이 없습니다.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(viewModel.allMeasurements) { measurement in
                                MeasurementRowView(measurement: measurement, isDeleteMode: $isDeleteMode, onDelete: {
                                    viewModel.deleteMeasurement(id: measurement.id)
                                })
                            }
                        }
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(key: ViewHeightKey.self, value: geo.size.height)
                            }
                        )
                    }
                    .frame(maxHeight: min(contentHeight, geometry.size.height - 50))
                }
            }
            .onPreferenceChange(ViewHeightKey.self) { height in
                contentHeight = height
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Constants.cornerRadius)
        .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(HistoryViewModel())
    }
}
