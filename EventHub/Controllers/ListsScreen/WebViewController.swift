//
//  WebViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 29.11.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: self.view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
