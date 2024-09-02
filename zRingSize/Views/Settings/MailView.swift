//
//  MailView.swift
//  zRingSize
//
//  Created by USER on 9/2/24.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    var result: (Result<MFMailComposeResult, Error>) -> Void

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        var result: (Result<MFMailComposeResult, Error>) -> Void

        init(isShowing: Binding<Bool>, result: @escaping (Result<MFMailComposeResult, Error>) -> Void) {
            _isShowing = isShowing
            self.result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result(.failure(error!))
                return
            }
            self.result(.success(result))
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, result: result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["jijiij99@gmail.com"])
        vc.setSubject("오류 및 문의사항")
        vc.setMessageBody("여기에 오류 문의 내용을 적어주세요:", isHTML: false)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
    }

    static var canSendMail: Bool {
        return MFMailComposeViewController.canSendMail()
    }
}
