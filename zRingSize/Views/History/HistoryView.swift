//
//  HistoryView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

// 측정 기록을 표시하는 View
struct HistoryView: View {
    // HistoryViewModel 인스턴스를 환경 객체로 사용
    @EnvironmentObject var viewModel: HistoryViewModel
    // 삭제 모드 상태를 관리하는 변수
    @State private var isDeleteMode = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 상단 헤더 부분
            HStack {
                Text("측정 기록")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                // 삭제 모드 토글 버튼
                Button(action: {
                    isDeleteMode.toggle()
                }) {
                    Image(systemName: isDeleteMode ? "chevron.right" : "trash")
                        .foregroundColor(isDeleteMode ? .green : .red)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal)

            // 측정 기록이 없을 경우 메시지 표시
            if viewModel.allMeasurements.isEmpty {
                Text("측정 기록이 없습니다.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                // 각 측정 기록을 행으로 표시
                ForEach(viewModel.allMeasurements) { measurement in
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

// 미리보기 제공자
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(HistoryViewModel())
    }
}
