//
//  HistoryView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import GoogleMobileAds

struct HistoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = HistoryViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.items.indices, id: \.self) { index in
                        let item = viewModel.items[index]
                        HStack {
                            VStack(alignment: .leading) {
                                Text("제목: \(item.title)")
                                Text("너비: \(String(format: "%.1f", (Double(item.size) ?? 0) * 10))mm")
                            }
                            Spacer()
                            Text("\(calcTimeSince(dateString: item.date))")
                                .foregroundColor(calcTimeColor(dateString: item.date))
                        }
                    }
                    .onDelete { indexSet in
                        deleteRecord(at: indexSet)
                    }
                }
                .navigationBarTitle("기록")
                .onAppear {
                    viewModel.fetchRecords() // 뷰가 나타날 때 데이터 로드
                }
                Spacer()
                GoogleAdView()
                    .frame(width: UIScreen.main.bounds.width, height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
            }
        }
    }
    
    private func calcTimeColor(dateString: String) -> Color {
        let isDarkMode = colorScheme == .dark
        let daysSince = calcDaysSince(dateString: dateString)
        
        if daysSince >= 10 {
            return isDarkMode ? .white : .black
        } else {
            return .red
        }
    }
    
    private func calcDaysSince(dateString: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return 0
        }
        
        let days = Int(-date.timeIntervalSinceNow) / (60 * 60 * 24)
        return days
    }
    
    private func deleteRecord(at indexSet: IndexSet) {
        indexSet.forEach { index in
            viewModel.deleteRecord(at: index)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
