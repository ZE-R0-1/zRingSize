import SwiftUI

struct RingView: View {
    @ObservedObject var viewModel: RingViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5])) // 점선으로 테두리를 설정합니다.
                        .foregroundColor(Color.black) // 테두리의 색상을 지정합니다.
                        .frame(width: viewModel.ringSize, height: viewModel.ringSize)
                    Text("반지") // 링 내부에 텍스트 (옵션)
                }
                .padding()
                
                Spacer()
                
                Text("반지 사이즈 : \(Int(viewModel.ringSize))") // 링의 크기를 표시하는 텍스트
                    .padding(.horizontal, 20) // 좌우 여백 추가
                
                Slider(value: $viewModel.ringSize, in: 100...250)
                    .padding([.leading, .trailing], 20) // 좌우 여백 추가
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
                    showingAlert = false // 알람 창을 닫습니다.
                }
            }
        }
    }
    
    func saveData() {
        let newItem = Sizer(context: viewContext)
        newItem.title = title
        newItem.date = Date()
        newItem.size = Double(viewModel.ringSize)
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
