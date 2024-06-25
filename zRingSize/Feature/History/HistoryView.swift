//
//  HistoryView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()

    var body: some View {
        VStack {
            TitleView()
            Spacer()
                .frame(height: 35)
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
            ScrollView {
                LazyVStack {
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
                            Button(action: {
                                deleteRecord(at: IndexSet(integer: index))
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchRecords() // 뷰가 나타날 때 데이터 로드
        }
    }

    private func calcTimeColor(dateString: String) -> Color {
        let daysSince = dateString.daysSince

        return daysSince >= 10 ? .black : .red
    }

    private func deleteRecord(at indexSet: IndexSet) {
        viewModel.deleteRecord(at: indexSet)
    }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("기록")
                .customFont(.largeTitle)
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 45)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

