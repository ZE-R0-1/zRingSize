//
//  RingSizeTab.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct RingSizeTab: View {
    @StateObject var viewModel: RingSizerViewModel
    
    var body: some View {
        VStack {
            Slider(value: $viewModel.ringSize, in: 0...30)
            Text("링 사이즈: \(viewModel.ringSize, specifier: "%.1f")mm")
        }
    }
}

struct RingSizeTab_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RingSizerViewModel()
        RingSizeTab(viewModel: viewModel)
    }
}


