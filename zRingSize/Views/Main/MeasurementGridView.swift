//
//  MeasurementGridView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

// 측정 유형 선택을 위한 그리드 뷰
struct MeasurementGridView: View {
    // HomeViewModel 인스턴스를 환경 객체로 사용
    @EnvironmentObject var viewModel: HomeViewModel
    // 측정 화면 표시 여부를 바인딩
    @Binding var showingAddMeasurement: Bool
    
    // 그리드 레이아웃을 위한 컬럼 정의
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            measurementButton(title: "반지 측정", icon: "circle", tab: .ring)
            measurementButton(title: "손가락 측정", icon: "hand.point.up.fill", tab: .finger)
        }
    }
    
    // 측정 버튼 생성 함수
    private func measurementButton(title: String, icon: String, tab: Tab) -> some View {
        Button(action: {
            viewModel.changeTab(to: tab)
            showingAddMeasurement = true
        }) {
            VStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: Constants.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(Constants.largecornerRadius)
            .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: 5)
        }
    }
}

// 미리보기 제공자
struct MeasurementGridView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementGridView(showingAddMeasurement: .constant(false))
            .environmentObject(HomeViewModel())
            .previewLayout(.sizeThatFits)
    }
}
