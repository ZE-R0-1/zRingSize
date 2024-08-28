//
//  CustomAlert.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String
    let primaryButtonTitle: String
    let primaryAction: () -> Void
    let secondaryButtonTitle: String
    let secondaryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                Button(action: secondaryAction) {
                    Text(secondaryButtonTitle)
                        .foregroundColor(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(Constants.cornerRadius)
                }
                
                Button(action: primaryAction) {
                    Text(primaryButtonTitle)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Constants.primaryColor)
                        .cornerRadius(Constants.cornerRadius)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: 10)
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(
            title: "알림",
            message: "이 작업을 수행하시겠습니까?",
            primaryButtonTitle: "확인",
            primaryAction: {},
            secondaryButtonTitle: "취소",
            secondaryAction: {}
        )
        .padding()
    }
}
