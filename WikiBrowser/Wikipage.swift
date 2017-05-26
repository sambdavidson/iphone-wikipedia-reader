//
//  Wikipage.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/20/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//
import UIKit

class Wikipage: NSObject, UIWebViewDelegate {
    
    public weak var parent:Wikipage?
    public var url:URL
    public var webView:UIWebView
    public var locked = false
    
    public var articleName:String {
        return _articleName
    }
    
    public var children:[Wikipage] {
        return _children
    }
    
    public var unviewed:Bool {
        return _unviewed
    }
    
    public var loaded:Bool {
        return _loaded
    }
    
    public var depth:Int {
        if let par = parent {
            return 1 + par.depth
        } else {
            return 0
        }
    }
    public var count:Int {
        var c:Int = 0
        _children.forEach({ c = c + $0.count })
        return c + 1
    }
    
    public var bookFlair:Character {
        return _bookFlair
    }
    
    private var _bookFlair:Character
    private var _children:[Wikipage] = []
    private var _unviewed:Bool = true
    private var _articleName:String
    private var _urlParser:URLParser = URLParser()
    private var _loaded:Bool = false
    private var _parentCollection:WikipediaCollection?
    
    init(url u:URL, collection c:WikipediaCollection?) {
        url = u
        _parentCollection = c
        
        let postfix = u.absoluteString.replacingOccurrences(of: _urlParser.urlPrefix, with: "").replacingOccurrences(of: "_", with: " ")
        
        _articleName = postfix.removingPercentEncoding ?? postfix
        
        webView = UIWebView()
        webView.loadRequest(URLRequest(url: u))
        
        /* Generate book flair */
        let books = "📗📘📙📕"
        let offset = books.characters.count
        let index = books.index(books.startIndex, offsetBy: abs(_articleName.hash) % offset)
        _bookFlair = books[index]
        
        super.init()
        webView.delegate = self
    }

    public func addChild(_ c:Wikipage) {
        if(!hasImmediateChild(c)) {
            c.parent = self
            _children.append(c)
        }
    }
    public func hasImmediateChild(_ c:Wikipage)->Bool {
        let apIndex = _children.index(where: { $0.articleName == c.articleName })
        if let _ = apIndex {
            return true
        }
        return false
    }
    public func removeImmediateChild(_ c:Wikipage) {
        let apIndex = _children.index(where: { $0.articleName == c.articleName })
        if let i = apIndex {
            _children[i].parent = nil
            _ = _children.remove(at: i)
        }
    }
    
    public func removeChildren() {
        for c in _children {
            c.parent =  nil
        }
        _children.removeAll()
    }
    
    public func removeChildRecursive(_ p:Wikipage) {
        
        var newChildren:[Wikipage] = []
        
        for c in _children {
            c.removeChildRecursive(p)
            
            if c.articleName == p.articleName {
                for cc in c.children {
                    newChildren.append(cc)
                }
                c.removeChildren()
            }
        }
        
        for c in newChildren {
            c.parent = self
            _children.append(c)
        }
    }
    
    public func markViewed() {
        _unviewed = false;
    }
    
    public func containsArticle(name: String)->Bool {
        if _articleName == name {
            return true
        }
        
        for child in _children {
            if child.articleName == name {
                return true
            }
        }
        
        return false
    }
    public func getPageAtOffset(_ i:Int)->Wikipage? {
        if i == 0 {
            return self
        }
        var r = i - 1
        for child in _children {
            if r - child.count < 0 {
                return child.getPageAtOffset(r)
            } else {
                r = r - child.count
            }
        }
        return nil
    }
    
    public func GetDataForSaving()->NSDictionary {
        var dict = Dictionary<String,Any>()
        
        for child in _children {
            dict[child.url.absoluteString] = child.GetDataForSaving()
        }
        
        return (dict as NSDictionary)
    }
    
    public func LoadDataFromSave(_ d: NSDictionary) {
        for (name, children) in (d as! Dictionary<String,NSDictionary>) {
            let p = Wikipage(url: URL(string: name)!, collection: _parentCollection)
            p.parent = self
            p.LoadDataFromSave(children)
            _children.append(p)
        }
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        _loaded = true
        _parentCollection?.WikiPageUpdated(self)
    }
    
}
