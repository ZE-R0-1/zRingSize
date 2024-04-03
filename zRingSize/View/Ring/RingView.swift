//
//  RingViewModel.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/27.
//

import SwiftUI

struct RingView: View {
    @ObservedObject var viewModel: RingViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State private var title = ""
    @State private var selectedRingSizeIndex = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(Color.black)
                        .frame(width: viewModel.ringDiameter, height: viewModel.ringDiameter)
                    Text(viewModel.formattedRingSize)
                }
                .padding()
                
                

                
                Spacer()
                Text("반지 지름 : \(viewModel.ringDiameter)")
                Text("반지 둘레 : \(viewModel.calculateCircumference())")
            }
            .padding([.leading, .trailing], 70)
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
    
    
    func saveData() {
        let newItem = Sizer(context: viewContext)
        newItem.title = title
        newItem.date = Date()
        newItem.size = Double(viewModel.ringDiameter)
        
        title = ""
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(viewModel: RingViewModel())
    }
}
