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
        NavigationView {
            List {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("제목: \(item.title ?? "")")
                            Text("너비: \(String(format: "%.1f", item.size * 10))mm")
                        }
                        Spacer()
                        Text("\(calcTimeSince(date: item.date ?? Date()))").foregroundColor(.red)
                    }
                }
                .onDelete(perform: deleteItems) // 삭제 기능 추가
            }
            .navigationBarTitle("기록")
        }
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
