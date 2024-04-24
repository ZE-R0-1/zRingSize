//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI
import UIKit

struct RingView: View {
    @StateObject var viewModel = RingViewModel()
    
    @State private var showingAlert = false
    @State private var title = ""
    
    @AppStorage("vibrationEnabled") private var isVibrationEnabled = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Rectangle()
                    .frame(width: 350.00, height: 350.00, alignment: .center)
                    .colorInvert()
                    .overlay {
                        GeometryReader { geometry in
                            RingDisplayView(ringDiameter: viewModel.ringDiameter, geometry: geometry, ringSize: viewModel.filteredItems.first ?? "")
                        }
                        .padding()
                    }
                Slider(value: $viewModel.ringDiameter, in: 1.31...2.25, step: 0.01)
                    .padding([.leading, .trailing], 70)
                    .onChange(of: viewModel.ringDiameter) { newValue in
                        if isVibrationEnabled {
                            generateHapticFeedback()
                        }
                    }
                
                Text("반지 지름: \(String(format: "%.1f", viewModel.ringDiameter * 10))mm")
                Spacer()
            }
            .navigationBarTitle("반지", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("저장") {
                    showingAlert = true
                }
            )
            .alert("링사이즈", isPresented: $showingAlert) {
                TextField("제목을 적어주세요", text: $title)
                Button("확인") {
                    saveData() // 함수 호출
                    showingAlert = false
                    title = ""
                }
                Button("취소") {
                    showingAlert = false
                    title = ""
                }
            }
        }
    }
    
    private func saveData() {
        let formattedRingDiameter = String(format: "%.2f", viewModel.ringDiameter)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: Date())
        
        let record = SizeRecord(id: 0, title: title, size: formattedRingDiameter, date: formattedDate)
        _ = ModelManager.getInstance().SaveRecord(record: record)
    }
    
    private func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}

