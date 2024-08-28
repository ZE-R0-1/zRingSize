//
//  FingerView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct FingerView: View {
    @StateObject private var viewModel = FingerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSaveAlert = false
    @State private var measurementTitle = ""
    
    var body: some View {
        ZStack {
            Constants.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: Constants.padding) {
                Text("손가락 둘레: \(viewModel.fingerWidth, specifier: "%.1f") mm")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.primaryColor)
                
                MeasurementGuideView(size: viewModel.fingerWidth, type: .finger)
                    .frame(height: 250)
                
                VStack {
                    HStack {
                        Button(action: viewModel.decrementWidth) {
                            Image(systemName: "minus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Constants.primaryColor)
                        }
                        
                        Slider(value: $viewModel.fingerWidth, in: Constants.minFingerWidth...Constants.maxFingerWidth)
                            .accentColor(Constants.primaryColor)
                        
                        Button(action: viewModel.incrementWidth) {
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
            }
            .padding()
        }
        .navigationTitle("손가락 측정")
        .navigationBarItems(trailing: Button("완료") {
            presentationMode.wrappedValue.dismiss()
        })
        .alert(isPresented: $showingSaveAlert) {
            Alert(
                title: Text("측정 저장"),
                message: Text("이 측정에 대한 제목을 입력하세요"),
                primaryButton: .default(Text("저장")) {
                    viewModel.saveMeasurement(title: measurementTitle)
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
        .alert(isPresented: $viewModel.showingError) {
            Alert(title: Text("오류"), message: Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."), dismissButton: .default(Text("확인")))
        }
    }
}

struct FingerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FingerView()
        }
    }
}
