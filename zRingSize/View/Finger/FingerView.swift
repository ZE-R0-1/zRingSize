//
//  FingerView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import UIKit

struct FingerView: View {
    @StateObject var viewModel = FingerViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State private var title = ""
    
    @AppStorage("vibrationEnabled") private var isVibrationEnabled = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("손가락 너비: \(String(format: "%.1f", viewModel.fingerWidth * 10))mm")
                    .padding()
                Text("예상 반지 호수: \(viewModel.filteredItems.first ?? "")")
                Slider(value: $viewModel.fingerWidth, in: 1.50...2.25, step: 0.01)
                    .padding([.leading, .trailing], 70)
                    .onChange(of: viewModel.fingerWidth) { newValue in
                        if isVibrationEnabled {
                            generateHapticFeedback()
                        }
                    }
                Rectangle()
                    .frame(width: 350.00, height: 450.00, alignment: .center)
                    .colorInvert()
                    .overlay {
                        GeometryReader { geometry in
                            FingerDisplayView(fingerWidth: viewModel.fingerWidth, geometry: geometry)
                        }
                        .padding()
                    }
            }
            .navigationBarTitle("손가락", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("저장") {
                    showingAlert = true
                }
            )
            .alert("손가락 너비", isPresented: $showingAlert) {
                TextField("제목을 적어주세요", text: $title)
                Button("확인", action: saveData)
                Button("취소") {
                    showingAlert = false
                }
            }
        }
    }
    
    func saveData() {
        let newItem = Sizer(context: viewContext)
        newItem.title = title
        newItem.date = Date()
        newItem.size = Double(viewModel.fingerWidth)
        
        title = ""
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct FingerView_Previews: PreviewProvider {
    static var previews: some View {
        FingerView(viewModel: FingerViewModel())
    }
}
