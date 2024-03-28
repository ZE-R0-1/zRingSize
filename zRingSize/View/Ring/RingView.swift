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
    
    private let measurementFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2 // 소수점 자리수 설정
        formatter.numberFormatter.usesGroupingSeparator = true // 천 단위로 ,(쉼표) 표시
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(Color.black)
                        .frame(width: viewModel.ringSize, height: viewModel.ringSize)
                    Text("반지")
                }
                .padding()
                
                Spacer()
                
                // 반지 지름 표시
                Text("반지 지름 : \(formattedDiameter())")
                    .padding(.horizontal, 20)
                
                // 반지 둘레 표시
                Text("반지 둘레 : \(formattedCircumference())")
                    .padding(.horizontal, 20)
                
                HStack {
                    Button("-") {
                        viewModel.ringSize -= 50 // 슬라이더 값 감소
                    }
                    Slider(value: $viewModel.ringSize, in: 100...250)
                        .padding(.horizontal, 10)
                    Button("+") {
                        viewModel.ringSize += 50 // 슬라이더 값 증가
                    }
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
    }
    
    // 지름을 형식화하여 반환
    private func formattedDiameter() -> String {
        let diameter = Measurement(value: viewModel.ringSize, unit: UnitLength.millimeters)
        return measurementFormatter.string(from: diameter)
    }
    
    // 반지 둘레를 형식화하여 반환
    private func formattedCircumference() -> String {
        let radius = viewModel.ringSize / 2
        let circumferenceValue = 2 * Double.pi * radius
        let circumference = Measurement(value: circumferenceValue, unit: UnitLength.millimeters)
        return measurementFormatter.string(from: circumference)
    }
    
    func saveData() {
        let newItem = Sizer(context: viewContext)
        newItem.title = title
        newItem.date = Date()
        newItem.size = Double(viewModel.ringSize)
        
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
