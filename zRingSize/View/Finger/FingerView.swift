//
//  FingerView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct FingerView: View {
    @ObservedObject var viewModel: FingerViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text("손가락 두께: \(Int(viewModel.fingerThickness))")
                    .padding(.horizontal, 20)
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(Color.black)
                        .frame(width: viewModel.fingerThickness, height: 300)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                
                Slider(value: $viewModel.fingerThickness, in: 50...200) // 손가락 두께 조절을 위한 슬라이더
                    .padding([.leading, .trailing], 20)
                
                Spacer()
            }
            .navigationBarTitle("FingerSizer", displayMode: .inline)
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

struct FingerView_Previews: PreviewProvider {
    static var previews: some View {
        FingerView(viewModel: FingerViewModel())
    }
}
