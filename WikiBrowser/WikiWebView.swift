//
//  WikiWebView.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/25/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class WikiWebView: UIView, UIWebViewDelegate {
    
    private let wikiCollection:WikipediaCollection
    private let webView:UIWebView
    
    init(frame fr: CGRect, collection c: WikipediaCollection) {
        wikiCollection = c
        webView = UIWebView(frame: fr)
        super.init(frame: fr)
        
        webView.delegate = self
        webView.loadRequest(URLRequest(url: c.activePage.url))
        
        addSubview(webView)
    }
    
    public func setWikiPage(_ page:Wikipage) {
        webView.loadRequest(URLRequest(url: page.url))
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url {
            print(url.absoluteString)
            if(url.absoluteString == wikiCollection.rootPage.url.absoluteString) {
                return true
            } else {
                wikiCollection.AddSubpage(url: url)
                return false
            }
        }
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
