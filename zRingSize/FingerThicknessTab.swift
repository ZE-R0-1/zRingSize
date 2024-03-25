//
//  FingerThicknessTab.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import CoreData

struct FingerThicknessTab: View {
    @Binding var fingerThickness: Double
    @StateObject var viewModel: RingSizerViewModel
    var context: NSManagedObjectContext
    
    var body: some View {
        VStack {
            Slider(value: $fingerThickness, in: 0...30)
            Text("손가락 두께: \(fingerThickness, specifier: "%.1f")mm")
            
            Button("저장") {
                viewModel.saveFingerThickness(context: context, fingerThickness: fingerThickness)
            }
            .padding()
        }
    }
}

struct FingerThicknessTab_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RingSizerViewModel() // 뷰모델 생성
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType) // 임시 context 생성
        return FingerThicknessTab(fingerThickness: .constant(15.0), viewModel: viewModel, context: context)
    }
}
