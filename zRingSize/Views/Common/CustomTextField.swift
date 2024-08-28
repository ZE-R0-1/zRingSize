//
//  CustomTextField.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(Constants.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(Constants.primaryColor, lineWidth: 1)
            )
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeholder: "텍스트를 입력하세요", text: .constant(""))
            .padding()
    }
}
