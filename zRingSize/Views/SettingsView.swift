//
//  SettingsView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    var ringSizes: [(String, Double)] = [
        ("Small", 48),
        ("Medium", 54),
        ("Large", 62)
    ]
    
    var body: some View {
        NavigationView {
            List(ringSizes, id: \.0) { size in
                Text("\(size.0): \(size.1) mm")
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
