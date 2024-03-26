//
//  RingView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

// RingView.swift
import SwiftUI

struct RingView: View {
    @StateObject private var viewModel = RingViewModel()
    @State private var showSaveAlert = false
    @State private var itemTitle = ""
    
    var body: some View {
        VStack {
            Ring(size: viewModel.ringSize)
            Slider(value: $viewModel.ringSize, in: 10...100)
            Spacer()
        }
        .navigationBarTitle("Ring", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            showSaveAlert = true
        }) {
            Image(systemName: "square.and.pencil")
        })
        .alert("제목을 입력하세요", isPresented: $showSaveAlert) {
            TextField("제목", text: $itemTitle)
            Button("저장") {
                viewModel.saveItem(title: itemTitle, size: viewModel.ringSize)
                itemTitle = ""
            }
            Button("취소", role: .cancel) { }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
