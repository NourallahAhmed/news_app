//
//  WebKitViewController.swift
//  news
//
//  Created by NourAllah Ahmed on 03/01/2023.
//

import UIKit
import WebKit
class WebKitViewController: UIViewController {

    
    
    private let webKitView : WKWebView = {
        
        let preference = WKWebpagePreferences()
        preference.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        
        let webPage = WKWebView(frame: .zero, configuration: configuration)
        
        return webPage
        
    }()
    private let url : URL
    init(url:URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.view.addSubview(webKitView)
        
        
        self.webKitView.load(URLRequest(url: self.url))
        
    }
    
    
    override func viewDidLayoutSubviews() {
        self.webKitView.frame = view.bounds
    }


}
