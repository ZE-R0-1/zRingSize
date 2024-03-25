//
//  SavedSizesTab.swift
//  zRingSize
//
//  Created by KMUSER on 2024/03/25.
//

import SwiftUI
import CoreData

struct SavedSizesTab: View {
    @Binding var savedSizes: [Double]
    var viewModel: RingSizerViewModel
    var context: NSManagedObjectContext
    
    var body: some View {
        List {
            ForEach(savedSizes, id: \.self) { size in
                Text("\(size, specifier: "%.1f")mm")
            }
            .onDelete { offsets in
                viewModel.deleteSize(at: offsets, context: context)
            }
        }
        .onAppear {
            viewModel.fetchSavedSizes(context: context)
        }
    }
}


struct SavedSizesTab_Previews: PreviewProvider {
    static var previews: some View {
        SavedSizesTab(savedSizes: .constant([]), viewModel: RingSizerViewModel(), context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    }
}
