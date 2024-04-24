//
//  FingerViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

class FingerViewModel: ObservableObject {
    @Published var fingerWidth: CGFloat = 1.50
    let measurementModel = SizeModel()
    
    var formattedFingerSize: String {
        return String(format: "%.2f", self.fingerWidth)
    }
    
    var filteredItems: [String] {
        return measurementModel.ringSizes
            .filter { String(format: "%.2f", $0.value) == self.formattedFingerSize }
            .map { $0.key }
    }
}
