//
//  RingView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct RingView: View {
    @ObservedObject var viewModel: RingViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5])) // 점선으로 테두리를 설정합니다.
                        .foregroundColor(Color.black) // 테두리의 색상을 지정합니다.
                        .frame(width: viewModel.ringSize, height: viewModel.ringSize)
                    Text("반지") // 링 내부에 텍스트 (옵션)
                }
                .padding()
                
                Spacer()
                
                Text("반지 사이즈 : \(Int(viewModel.ringSize))") // 링의 크기를 표시하는 텍스트
                    .padding(.horizontal, 20) // 좌우 여백 추가
                
                Slider(value: $viewModel.ringSize, in: 100...250)
                    .padding([.leading, .trailing], 20) // 좌우 여백 추가
            }
            .navigationBarTitle("RingSizer", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    // 저장 기능 구현
                }) {
                    Text("저장")
                }
            )
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(viewModel: RingViewModel())
    }
}
