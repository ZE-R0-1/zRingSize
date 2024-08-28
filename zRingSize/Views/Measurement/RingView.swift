//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

struct RingView: View {
    @StateObject private var viewModel = RingViewModel()
    @State private var showingSaveAlert = false
    @State private var measurementTitle = ""
    
    var body: some View {
        ZStack {
            Constants.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: Constants.padding) {
                Text("반지 지름: \(viewModel.ringDiameter, specifier: "%.1f") mm")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.primaryColor)
                
                MeasurementGuideView(size: viewModel.ringDiameter, type: .ring)
                    .frame(height: 250)
                
                VStack {
                    HStack {
                        Button(action: viewModel.decrementDiameter) {
                            Image(systemName: "minus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Constants.primaryColor)
                        }
                        
                        Slider(value: $viewModel.ringDiameter, in: Constants.minRingDiameter...Constants.maxRingDiameter)
                            .accentColor(Constants.primaryColor)
                        
                        Button(action: viewModel.incrementDiameter) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Constants.primaryColor)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(Constants.cornerRadius)
                    .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
                }
                
                Text("예상 반지 사이즈: \(viewModel.ringSize)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Constants.secondaryColor)
                
                Button("측정 저장") {
                    showingSaveAlert = true
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: Constants.gradientColors), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(Constants.cornerRadius)
                .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
                
                RecentMeasurementsView(measurements: viewModel.recentMeasurements)
            }
            .padding()
        }
        .navigationTitle("반지 측정")
        .alert(isPresented: $showingSaveAlert) {
            Alert(
                title: Text("측정 저장"),
                message: Text("이 측정에 대한 제목을 입력하세요"),
                primaryButton: .default(Text("저장")) {
                    viewModel.saveMeasurement(title: measurementTitle)
                    measurementTitle = ""
                },
                secondaryButton: .cancel()
            )
        }
        .alert(isPresented: $viewModel.showingError) {
            Alert(title: Text("오류"), message: Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."), dismissButton: .default(Text("확인")))
        }
    }
}
