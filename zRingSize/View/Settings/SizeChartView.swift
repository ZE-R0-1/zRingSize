//
//  SizeChartView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/05.
//

import SwiftUI

struct SizeChartView: View {
    let measurementModel = MeasurementModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(measurementModel.ringSizes.sorted(by: { Int($0.key.replacingOccurrences(of: "호", with: "")) ?? 0 < Int($1.key.replacingOccurrences(of: "호", with: "")) ?? 0 }), id: \.key) { key, value in
                        Text("\(key)")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        Text(String(format: "%.1f mm", value * 10))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                .padding()
            }
            .navigationBarTitle("반지 사이즈")
        }
    }
}

struct SizeChartView_Previews: PreviewProvider {
    static var previews: some View {
        SizeChartView()
    }
}
