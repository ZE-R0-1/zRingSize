//
//  MeasurementRowView.swift
//  zRingSize
//
//  Created by zero on 8/18/24.
//

import SwiftUI

struct MeasurementRowView: View {
    let measurement: SizeRecord
    @Binding var isDeleteMode: Bool
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: measurement.type == SizeRecord.MeasurementType.ring.rawValue ? "circle" : "hand.point.up.fill")
                .foregroundColor(Constants.primaryColor)
                .font(.system(size: 24))
            VStack(alignment: .leading) {
                Text(measurement.title)
                    .font(.headline)
                Text("\(measurement.size, specifier: "%.1f") mm")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if isDeleteMode {
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            } else {
                Text(measurement.date.timeAgoDisplay())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(
            NavigationLink(destination: MeasurementDetailView(measurement: measurement)) {
                EmptyView()
            }.opacity(0)
        )
    }
}
