//
//  Ring.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/26.
//

import SwiftUI

struct Ring: View {
    let size: Double
    
    var body: some View {
        Circle()
            .stroke(Color.black, lineWidth: 2)
            .frame(width: size, height: size)
    }
}

struct Ring_Previews: PreviewProvider {
    static var previews: some View {
        Ring(size: 50)
    }
}
