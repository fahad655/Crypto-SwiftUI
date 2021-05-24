//
//  WebView.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
  @Binding var text: String
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
   
  func updateUIView(_ uiView: WKWebView, context: Context) {
    uiView.loadHTMLString(text, baseURL: nil)
  }
}
