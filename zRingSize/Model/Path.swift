//
//  Path.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
