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
    private var inset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    
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
        
        webView.delegate = nil
        
        webView = wikiCollection.activePage.webView
        webView.delegate = self

        webView.frame = frame
        webView.scrollView.contentInset = inset
        
        addSubview(webView)
    }
    
    func updateFrame(_ f:CGRect, navBarFrame: CGRect) {
        frame = f
        inset = UIEdgeInsets(top: navBarFrame.height, left: 0, bottom: 0, right: 0)
        reloadActivePage()
    }
    
    
    /* Web View delegate handler */
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
