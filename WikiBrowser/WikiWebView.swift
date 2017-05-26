//
//  WikiWebView.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/25/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class WikiWebView: UIView, UIWebViewDelegate {
    
    private var webView:UIWebView
    
    private let wikiCollection:WikipediaCollection
    private let urlParser = URLParser()
    
    init(frame fr: CGRect, collection c: WikipediaCollection) {
        wikiCollection = c
        webView = c.activePage.webView
        super.init(frame: fr)
        
        wikiCollection.RegisterOnActivePageChange(self.onActivePageChange)
        
        reloadActivePage()
        
    }
    
    public func onActivePageChange(_ p:Wikipage?) {
        reloadActivePage()
    }
    
    public func reloadActivePage() {
        
        
        subviews.forEach({ $0.removeFromSuperview() })
        
        webView = wikiCollection.activePage.webView
        webView.delegate = self

        webView.frame = frame
        webView.scrollView.contentInset = .init(top: 44, left: 0, bottom: 0, right: 0)
        
        addSubview(webView)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url {
            print(url.absoluteString)
            if(urlParser.IsAWikiArticle(url: url)) {
                wikiCollection.AddSubpage(url: url)
                return false
            }
        }
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
