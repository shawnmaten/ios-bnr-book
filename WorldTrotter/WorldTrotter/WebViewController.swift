//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Shawn Aten on 8/18/18.
//  Copyright © 2018 Shawn Aten. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.bignerdranch.com/") {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("Coudln't parse URL from string!")
        }
    }
    
}


