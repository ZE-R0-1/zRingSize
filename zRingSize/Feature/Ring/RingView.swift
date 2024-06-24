//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI
import GoogleMobileAds

struct RingView: View {
    @StateObject var viewModel = RingViewModel()
    
    @State private var showingAlert = false
    @State private var title = ""
    @AppStorage("vibrationEnabled") private var isVibrationEnabled = true
    
    private var onecentimeter: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let nativeWidth = UIScreen.main.nativeBounds.width
        let nativeHeight = UIScreen.main.nativeBounds.height
        let screenDiagonal = CGFloat(hypot(screenWidth, screenHeight)) // 대각선 길이 (포인트 단위)
        let screenInches = DeviceInfo.screenSize(forWidth: nativeWidth, height: nativeHeight)! // 실제 화면 크기 (인치 단위)
        let pointsPerInch = screenDiagonal / screenInches // 1인치당 포인트 수
        return CGFloat(pointsPerInch / 2.54) // 1cm 길이 (포인트 단위)
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 20) {
                    Spacer()
                    RingDisplayView(viewModel: viewModel, ringDiameter: viewModel.ringDiameter * onecentimeter)
                        .frame(width: min(geometry.size.width, geometry.size.height) * 0.6, height: min(geometry.size.width, geometry.size.height) * 0.6)
                        .background(.linearGradient(colors: [Color(hex: "FFFBDA"), Color(hex: "FFFBDA").opacity(0.5)], startPoint: .topLeading, endPoint: .bottomLeading))
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color(hex: "7850F0").opacity(0.3), radius: 8, x: 0, y: 12)
                        .shadow(color: Color(hex: "7850F0").opacity(0.3), radius: 2, x: 0, y: 1)
                    Spacer()
                    Slider(value: $viewModel.ringDiameter, in: 1.31...2.25, step: 0.01)
                        .padding([.leading, .trailing], 70)
                        .onChange(of: viewModel.ringDiameter) { newValue in
                            if isVibrationEnabled {
                                generateHapticFeedback()
                            }
                        }
                    
                    Text("반지 지름: \(String(format: "%.1f", viewModel.ringDiameter * 10))mm")
                    GoogleAdView()
                        .frame(width: UIScreen.main.bounds.width, height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
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
