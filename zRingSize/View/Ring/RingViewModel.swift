//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

class RingViewModel: ObservableObject {
    @Published var ringDiameter: Double = 1.50
    
    let ringSizes: [String: CGFloat] = [
        "7호": 1.50,
        "8호": 1.54,
        "9호": 1.58,
        "10호": 1.60,
        "11호": 1.64,
        "12호": 1.66,
        "13호": 1.70,
        "14호": 1.72,
        "15호": 1.77,
        "16호": 1.80,
        "17호": 1.83,
        "18호": 1.86,
        "19호": 1.90,
        "20호": 1.93,
        "21호": 1.96,
        "22호": 1.98,
        "23호": 2.01,
        "24호": 2.05,
        "25호": 2.08,
        "26호": 2.11,
        "27호": 2.15,
        "28호": 2.18,
        "29호": 2.21,
        "30호": 2.25
    ]
    
    var formattedRingSize: String {
        return Array(ringSizes.keys)[Int(ringDiameter * 2 - 3)] // assuming ringDiameter is in range of ringSizes
    }
    
    func updateRingDiameter(index: Int) {
        guard index >= 0 && index < ringSizes.count else { return }
        let ringSizeValues = Array(ringSizes.values)
        ringDiameter = ringSizeValues[index]
    }
    
    func calculateCircumference() -> CGFloat {
        let diameter = ringDiameter
        let circumference = diameter * CGFloat.pi
        return circumference
    }
}

