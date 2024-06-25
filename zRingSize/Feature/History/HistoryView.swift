//
//  HistoryView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = HistoryViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    let item = viewModel.items[index]
                    HStack {
                        VStack(alignment: .leading) {
                            Text("제목: \(item.title)")
                            Text("너비: \(String(format: "%.1f", (Double(item.size) ?? 0) * 10))mm")
                        }
                        Spacer()
                        Text("\(item.date.timeSince)")
                            .foregroundColor(calcTimeColor(dateString: item.date))
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteRecord(at: indexSet)
                }
            }
            .navigationBarTitle("기록")
            .onAppear {
                viewModel.fetchRecords()
            }
        }
    }
    
    private func calcTimeColor(dateString: String) -> Color {
        let isDarkMode = colorScheme == .dark
        let daysSince = dateString.daysSince
        
        if daysSince >= 10 {
            return isDarkMode ? .white : .black
        } else {
            return .red
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
