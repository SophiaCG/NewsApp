//
//  WebViewVC.swift
//  News-App
//
//  Created by SCG on 10/26/21.
//

import UIKit
import WebKit


import Foundation
import WebKit

// Code from: https://betterprogramming.pub/create-a-wkwebview-programmatically-in-swift-5-fc08c8ad8708

class WebViewVC: UIViewController, WKUIDelegate {
    
    var webURL: String
    
    init(webURL: String) {
        self.webURL = webURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavItem()
        let myURL = URL(string: webURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    // MARK: - Actions
    @objc func forwardAction() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func backAction() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    // MARK: - Properties
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let forwardBarItem = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(forwardAction))
    
    let backBarItem = UIBarButtonItem(title: "Backward", style: .plain, target: self, action: #selector(backAction))
    
}

extension WebViewVC {
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func setupNavItem() {
        self.navigationItem.leftBarButtonItem = backBarItem
        self.navigationItem.rightBarButtonItem = forwardBarItem
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar
            .barTintColor = .systemBlue
        self.navigationController?.navigationBar
            .tintColor = .white
    }
}

