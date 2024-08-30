//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

// 반지 측정 화면을 나타내는 View 구조체
struct RingView: View {
    // ViewModel 인스턴스 생성
    @StateObject private var viewModel = RingViewModel()
    // 측정 제목을 저장하는 상태 변수
    @State private var measurementTitle = ""
    // 현재 화면의 표시 상태를 관리하는 환경 변수
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var isTitleFocused: Bool

    var body: some View {
        ZStack {
            // 배경 그라데이션
            LinearGradient(gradient: Gradient(colors: [Color.white, Color(UIColor.systemGray6)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    titleSection
                    measurementGuideSection
                    sizeInfoSection
                    sliderSection
                    saveButton
                }
                .padding()
            }
        }
        .navigationBarTitle("반지 측정", displayMode: .inline)
        // 에러 표시를 위한 알림 설정
        .alert(isPresented: $viewModel.showingError) {
            Alert(title: Text("오류"), message: Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."), dismissButton: .default(Text("확인")))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isTitleFocused = true
            }
        }
    }

    // 측정 제목 입력 섹션
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("측정 제목")
                .font(.headline)
                .foregroundColor(.secondary)
            TextField("예: 내 결혼반지", text: $measurementTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.body)
                .focused($isTitleFocused)
        }
    }
    
    // 측정 가이드 섹션
    private var measurementGuideSection: some View {
        VStack {
            MeasurementGuideView(size: viewModel.ringDiameter / 10, type: .ring)
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
    
    // 크기 정보 표시 섹션
    private var sizeInfoSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("반지 지름")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(viewModel.ringDiameter, specifier: "%.1f") mm")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                Text("예상 반지 사이즈")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(viewModel.ringSize)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    // 슬라이더 섹션
    private var sliderSection: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: viewModel.decrementDiameter) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
                
                Slider(value: $viewModel.ringDiameter, in: Constants.minRingDiameter...Constants.maxRingDiameter, step: 0.1)
                    .accentColor(.blue)
                
                Button(action: viewModel.incrementDiameter) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
            }
            Text("슬라이더를 움직여 정확한 크기를 조절하세요")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    // 저장 버튼
    private var saveButton: some View {
        Button(action: {
            // 측정 데이터 저장 및 화면 닫기
            viewModel.saveMeasurement(title: measurementTitle)
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("측정 저장")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(measurementTitle.isEmpty ? Color.gray : Color.blue)
                .cornerRadius(15)
        }
        .disabled(measurementTitle.isEmpty)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RingView()
        }
    }
}
