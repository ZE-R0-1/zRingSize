//
//  EmailSender.swift
//  zRingSize
//
//  Created by zero on 6/14/24.
//

import Combine
import SwiftUI
import MessageUI

struct EmailSender: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        let contents = """
            앱 이름: 반지측정하기
        
        """
        mail.setSubject("반지측정하기 문의")
        mail.setToRecipients(["jijiij99@gmail.com"])
        mail.setMessageBody(contents, isHTML: false)
        
        mail.mailComposeDelegate = context.coordinator
        return mail
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    typealias UIViewControllerType = MFMailComposeViewController
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
        var parent: EmailSender
        
        init(_ parent: EmailSender) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
