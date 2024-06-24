//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

class RingViewModel: ObservableObject {
    @Published var ringDiameter: CGFloat = 1.31
    
    let measurementModel = SizeModel()
    
    var formattedRingSize: String {
        return String(format: "%.2f", self.ringDiameter)
    }
    
    var filteredItems: [String] {
        return measurementModel.ringSizes
            .filter { String(format: "%.2f", $0.value) == self.formattedRingSize }
            .map { $0.key }
    }
}

