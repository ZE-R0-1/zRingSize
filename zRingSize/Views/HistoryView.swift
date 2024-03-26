//
//  HistoryView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

// HistoryView.swift
import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.measurements) { measurement in
                    VStack(alignment: .leading) {
                        Text(measurement.title ?? "Unnamed")
                            .font(.headline)
                        Text("Size: \(measurement.size, specifier: "%.1f")")
                        Text("Saved: \(measurement.date?.formatted() ?? "")")
                            .font(.caption)
                    }
                }
            }
            .navigationBarTitle("History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
