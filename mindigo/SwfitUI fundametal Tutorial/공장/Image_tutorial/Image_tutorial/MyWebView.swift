//
//  MyWebView.swift
//  Image_tutorial
//
//  Created by min on 2023/09/11.
//

import SwiftUI
import WebKit

struct MyWebView: UIViewRepresentable {
    
    var urlToLoad: String
    
    func makeUIView(context: Context) -> WKWebView {
        
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
        //
    }
}
