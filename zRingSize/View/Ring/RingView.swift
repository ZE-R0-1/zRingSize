//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI
import UIKit

struct RingView: View {
    @StateObject var viewModel = RingViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Rectangle()
                    .frame(width: 350.00, height: 350.00, alignment: .center)
                    .colorInvert()
                    .overlay {
                        GeometryReader { geometry in
                            RingDisplayView(ringDiameter: viewModel.ringDiameter, geometry: geometry, ringSize: viewModel.filteredItems.first ?? "")
                        }
                        .padding()
                    }
                Slider(value: $viewModel.ringDiameter, in: 1.50...2.25, step: 0.01)
                    .padding([.leading, .trailing], 70)
                    .onChange(of: viewModel.ringDiameter) { newValue in
                        if let ringSize = viewModel.filteredItems.first {
                            generateHapticFeedback(for: ringSize)
                        }
                    }
                
                Text("반지 지름: \(String(format: "%.1f", viewModel.ringDiameter * 10))mm")
                Spacer()
            }
            .navigationBarTitle("RingSizer", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("저장") {
                    showingAlert = true
                }
            )
            .alert("링사이즈", isPresented: $showingAlert) {
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
        newItem.size = viewModel.ringDiameter
        
        title = ""
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func generateHapticFeedback(for ringSize: String) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
