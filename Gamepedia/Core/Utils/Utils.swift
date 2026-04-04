//
//  Utils.swift
//  Gamepedia
//
//  Created by User on 05/01/26.
//

import SwiftUI
import UIKit
import WebKit

func dateFormat(dateTxt: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: dateTxt) else { return "" }

    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: date)
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    @Binding var contentHeight: CGFloat

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let htmlString = """
            <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body {
                        font-family: -apple-system, BlinkMacSystemFont, sans-serif;
                        font-size: 16px;
                        line-height: 1.6;
                        margin: 0;
                        padding: 0;
                        color: white;
                        background-color: transparent;
                    }
                </style>
            </head>
            <body>\(htmlContent)</body>
            </html>
            """
        webView.loadHTMLString(htmlString, baseURL: nil)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: HTMLStringView

        init(_ parent: HTMLStringView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
        {
            webView.evaluateJavaScript("document.readyState") {
                complete,
                error in
                if complete != nil {
                    webView.evaluateJavaScript("document.body.scrollHeight") {
                        height,
                        error in
                        if let height = height as? CGFloat {
                            DispatchQueue.main.async {
                                self.parent.contentHeight = height
                            }
                        }
                    }
                }
            }
        }
    }
}
