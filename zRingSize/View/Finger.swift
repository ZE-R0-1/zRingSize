//
//  Finger.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/26.
//

import SwiftUI

struct Finger: View {
    let thickness: Double
    
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: thickness * 4, height: thickness * 10)
            .cornerRadius(thickness)
    }
}

struct Finger_Previews: PreviewProvider {
    static var previews: some View {
        Finger(thickness: 10)
    }
}
