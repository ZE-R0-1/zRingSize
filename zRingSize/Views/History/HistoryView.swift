//
//  HistoryView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.measurements) { measurement in
                NavigationLink(destination: MeasurementDetailView(measurement: measurement)) {
                    MeasurementRowView(measurement: measurement)
                }
            }
            .onDelete(perform: viewModel.deleteMeasurement)
        }
        .navigationTitle("측정 기록")
        .navigationBarItems(trailing: EditButton())
        .onAppear {
            viewModel.fetchMeasurements()
        }
        .alert(isPresented: $viewModel.showingError) {
            Alert(
                title: Text("오류"),
                message: Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView()
        }
    }
}
