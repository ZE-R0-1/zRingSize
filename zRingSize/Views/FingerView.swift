//
//  FingerView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct FingerView: View {
    @StateObject private var viewModel = FingerViewModel()
    @State private var showSaveAlert = false
    @State private var itemTitle = ""
    
    var body: some View {
        VStack {
            Finger(thickness: viewModel.fingerThickness)
            Slider(value: $viewModel.fingerThickness, in: 5...20)
            Spacer()
        }
        .navigationBarTitle("Finger", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            showSaveAlert = true
        }) {
            Image(systemName: "square.and.pencil")
        })
        .alert("제목을 입력하세요", isPresented: $showSaveAlert) {
            TextField("제목", text: $itemTitle)
            Button("저장") {
                if !itemTitle.isEmpty {
                    viewModel.saveItem(title: itemTitle, size: viewModel.fingerThickness)
                    itemTitle = ""
                    showSaveAlert = false // 저장 버튼을 누른 후 Alert를 닫습니다.
                }
            }
            .disabled(itemTitle.isEmpty) // 제목이 비어 있을 경우 저장 버튼을 비활성화합니다.
            Button("취소", role: .cancel) { }
        }
    }
}

struct FingerView_Previews: PreviewProvider {
    static var previews: some View {
        FingerView()
    }
}
