//
//  HistoryView.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Sizer.date, ascending: false)]) private var items: FetchedResults<Sizer>

    var body: some View {
        List {
            ForEach(items) { item in
                VStack(alignment: .leading) {
                    Text("Title: \(item.title ?? "")")
                    Text("Date: \(item.date ?? Date())")
                    Text("Size: \(item.size)")
                }
            }
            .onDelete(perform: deleteItems) // Delete 기능 추가
        }
        .navigationBarTitle("History")
        .navigationBarItems(trailing: NavigationLink(destination: RingView(viewModel: RingViewModel())) {
            Image(systemName: "plus") // Plus 아이콘을 누르면 RingView로 이동하여 새 데이터 생성 가능
        })
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
