//
//  SettingsItemView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct SettingsItemView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            content
        }
    }
}

struct SettingsItemView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            SettingsItemView(title: "테스트 설정") {
                Toggle("", isOn: .constant(true))
            }
        }
    }
}
