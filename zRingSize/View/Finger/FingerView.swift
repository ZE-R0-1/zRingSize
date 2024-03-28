//
//  FingerView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI

struct FingerView: View {
    @ObservedObject var viewModel: FingerViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State private var title = ""
    
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
                
                Slider(value: $viewModel.fingerThickness, in: 50...200)
                    .padding([.leading, .trailing], 20)
            }
            .navigationBarTitle("FingerSizer", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("저장") {
                    showingAlert = true
                }
            )
            .alert("손가락 두께", isPresented: $showingAlert) {
                TextField("제목을 적어주세요", text: $title)
                Button("확인", action: saveData)
                Button("취소") {
                    showingAlert = false // 알람 창을 닫습니다.
                }
            }
        }
    }
    
    func saveData() {
        let newItem = Sizer(context: viewContext)
        newItem.title = title
        newItem.date = Date()
        newItem.size = Double(viewModel.fingerThickness)
        
        title = ""
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct FingerView_Previews: PreviewProvider {
    static var previews: some View {
        FingerView(viewModel: FingerViewModel())
    }
}
