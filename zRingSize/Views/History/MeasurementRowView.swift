//
//  MeasurementRowView.swift
//  zRingSize
//
//  Created by zero on 8/18/24.
//

import SwiftUI

// 각 측정 기록을 표시하는 행 View
struct MeasurementRowView: View {
    let measurement: SizeRecord  // 표시할 측정 기록
    @Binding var isDeleteMode: Bool  // 삭제 모드 여부
    var onDelete: () -> Void  // 삭제 동작

    var body: some View {
        NavigationLink(destination: MeasurementDetailView(measurement: measurement)) {
            HStack {
                // 측정 유형에 따른 아이콘 표시
                Image(systemName: measurement.type == SizeRecord.MeasurementType.ring.rawValue ? "circle" : "hand.point.up.fill")
                    .foregroundColor(Constants.primaryColor)
                    .font(.system(size: 24))
                // 측정 제목과 크기 표시
                VStack(alignment: .leading) {
                    Text(measurement.title)
                        .font(.headline)
                    Text("\(measurement.size, specifier: "%.1f") mm")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                // 삭제 모드일 때 삭제 버튼 표시, 아닐 때 날짜 정보 표시
                if isDeleteMode {
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                } else {
                    Text(measurement.date.timeAgoDisplay())
                        .font(.caption)
                        .foregroundColor(colorForDate(measurement.date))
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // 날짜에 따른 색상 반환 함수
    private func colorForDate(_ date: Date) -> Color {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return .blue
        } else if calendar.isDateInYesterday(date) {
            return .green
        } else {
            return .secondary
        }
    }
}

// 미리보기 제공자
struct MeasurementRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeasurementRowView(
                measurement: SizeRecord(title: "내 반지", size: 16.5, type: .finger),
                isDeleteMode: .constant(false),
                onDelete: {}
            )
        }
    }
}
