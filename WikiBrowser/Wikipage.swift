//
//  Wikipage.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/20/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//
import UIKit

class Wikipage {
    
    public weak var parent:Wikipage?
    public var url:URL
    public var webView:UIWebView
    
    public var articleName:String {
        return _articleName
    }
    
    public var children:[Wikipage] {
        return _children
    }
    
    public var unviewed:Bool {
        return _unviewed
    }
    public var count:Int {
        var c:Int = 0
        _children.forEach({ c = c + $0.count })
        return c + 1
    }
    
    private var _children:[Wikipage] = []
    private var _unviewed:Bool = true
    private var _articleName:String
    
    init(url u:URL) {
        url = u
        
        _articleName = u.absoluteString //TODO
        
        webView = UIWebView()
        webView.loadRequest(URLRequest(url: u))
    }

    public func addChild(_ c:Wikipage) {
        if(!hasChild(c)) {
            c.parent = self
            _children.append(c)
        }
    }
    public func hasChild(_ c:Wikipage)->Bool {
        let apIndex = _children.index(where: { $0.articleName == c.articleName })
        if let _ = apIndex {
            return true
        }
        return false
    }
    public func removeChild(_ c:Wikipage) {
        let apIndex = _children.index(where: { $0.articleName == c.articleName })
        if let i = apIndex {
            _ = _children.remove(at: i)
        }
    }
    
    public func markViewed() {
        _unviewed = false;
    }
}
