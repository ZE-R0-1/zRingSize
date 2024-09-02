//
//  SizeChartView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct SizeChartView: View {
    let sizeModel = SizeModel()
    
    var body: some View {
        List {
            ForEach(SizeModel.ringSizes.sorted(by: { $0.value < $1.value }), id: \.key) { size, diameter in
                HStack {
                    Text(size)
                    Spacer()
                    Text("\(diameter, specifier: "%.1f") mm")
                }
            }
        }
        .navigationTitle("반지 사이즈 차트")
    }
}

struct SizeChartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SizeChartView()
        }
    }
}
