//
//  WebView.swift
//  zRingSize
//
//  Created by zero on 7/27/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://www.naver.com")
    }
}
