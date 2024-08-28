//
//  CustomButton.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    var backgroundColor: Color = Constants.primaryColor
    var foregroundColor: Color = .white
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .cornerRadius(Constants.cornerRadius)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomButton(title: "기본 버튼", action: {})
            CustomButton(title: "커스텀 버튼", action: {}, backgroundColor: .red, foregroundColor: .yellow)
        }
        .padding()
    }
}
