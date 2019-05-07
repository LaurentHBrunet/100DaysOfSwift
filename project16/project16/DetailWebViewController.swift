//
//  DetailWebViewController.swift
//  project16
//
//  Created by Laurent on 2019-05-06.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var city: String!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://en.wikipedia.org/wiki/" + city)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
