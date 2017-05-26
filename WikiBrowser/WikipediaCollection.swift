//
//  WikipediaCollection.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/20/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//
import UIKit

class WikipediaCollection {
    
    private var root:Wikipage
    private var heads:[Wikipage] = []
    private var active:Wikipage?
    
    /* Callbacks */
    private var _OnPageAdded:[(_ page:Wikipage?)->Void] = []
    private var _OnActivePageChange:[(_ page:Wikipage?)->Void] = []
    private var _OnPageRemoved:[(_ page:Wikipage?)->Void] = []
    private var _OnPageLoaded:[(_ page:Wikipage?)->Void] = []
    
    public var count: Int {
        var c = 0;
        heads.forEach({ c = c + $0.count })
        return c;
    }
    
    public var unread: Int {
        return -1;
    }
    
    public var rootPage: Wikipage {
        return root
    }
    
    public var activePage: Wikipage {
        if let pg = active {
            return pg
        } else {
            return root
        }
    }
    
    init() {
        root = Wikipage(url: URL(string: "https://en.m.wikipedia.org/wiki/Main_Page")!)
    }
    

    public func SetActivePage(page:Wikipage) {
        active = page
        
        page.markViewed()

        for cb in _OnActivePageChange {
            cb(page)
        }
    }
    
    public func AddSubpage(url:URL) {
        
        let newPage = Wikipage(url: url)
        
        for head in heads {
            if head.containsArticle(name: newPage.articleName) {
                return
            }
        }
        
        if let ap = active {
            ap.addChild(newPage)
        } else {
            heads.append(newPage)
        }
        for cb in _OnPageAdded {
            cb(newPage)
        }
    }
    
    public func NextPage() {
        if let ap = active {
            if ap.children.count > 0 { // Read all children before deleting self.
                ap.children.first?.markViewed()
                active = ap.children.first
            } else { //No chilren, delete self and move on
                if let parent = ap.parent { // Do we at least have a parent to go to
                    parent.removeImmediateChild(ap)
                    if parent.children.count > 0 { // Siblings?
                        parent.children.first?.markViewed()
                        active = parent.children.first
                    } else {
                        parent.markViewed()
                        active = parent
                    }
                } else { // We are an orphan :'(
                    let hIdx = heads.index(where: { $0.articleName == ap.articleName })
                    if let i = hIdx {
                        _ = heads.remove(at: i)
                    }
                    
                    if heads.count > 0 { //Anything left?
                        heads.first?.markViewed()
                        active = heads.first
                    } else {
                        active = nil
                    }
                }
            }
            for cb in _OnActivePageChange {
                cb(nil)
            }
            
            return
            
        } else if heads.count > 0 {
            heads.first?.markViewed()
            active = heads.first
        }
        for cb in _OnActivePageChange {
            cb(nil)
        }
    }
    
    public func GetWhatsNext()->(Wikipage?, WikiQueueDirection?) {
        if let ap = active {
            if ap.children.count > 0 {
                return (ap.children.first, WikiQueueDirection.child)
            }
            if let par = ap.parent {
                if par.children.count > 1 {
                    let n  = par.children.first
                    if n!.articleName == ap.articleName {
                        return (par.children[1], WikiQueueDirection.sibling)
                    }
                    return (n, WikiQueueDirection.sibling)
                } else {
                    return (par, WikiQueueDirection.parent)
                }
            }
            if heads.count > 1 {
                let n = heads.first
                if n!.articleName == ap.articleName {
                    return (heads[1], WikiQueueDirection.sibling)
                }
                return (n, WikiQueueDirection.sibling)
            }
        } else if heads.count > 0 {
            return (heads.first, WikiQueueDirection.sibling)
        }
        return (nil, nil)
    }
    
    public func GetPageAtOffset(_ i:Int)->Wikipage? {
        var r = i
        for head in heads {
            if r - head.count < 0 {
                return head.getPageAtOffset(r)
            } else {
                r = r - head.count
            }
        }
        return nil
    }
    
    public func RemovePage(wiki:Wikipage) {
        
        var newHeads:[Wikipage] = []
        
        if let a = active {
            if a.articleName == wiki.articleName {
                active = nil //TODO double check this does what I want!
            }
        }
        
        for i in 0 ..< heads.count {
            
            if i >= heads.count {
                break;
            }
            
            let head = heads[i]
            
            head.removeChildRecursive(wiki)
            
            if head.articleName == wiki.articleName {
                for c in head.children {
                    newHeads.append(c)
                }
                head.removeChildren()
                heads.remove(at: i)
            }
        }
        
        
        heads.append(contentsOf: newHeads)
        
        for cb in _OnPageRemoved {
            cb(wiki)
        }
    }
    
    public func RegisterOnPageAdded(_ f:@escaping (_ page:Wikipage?)->Void) {
        _OnPageAdded.append(f)
    }
    
    public func RegisterOnPageRemoved(_ f:@escaping (_ page:Wikipage?)->Void) {
        _OnPageRemoved.append(f)
    }
    public func RegisterOnActivePageChange(_ f:@escaping (_ page:Wikipage?)->Void) {
        _OnActivePageChange.append(f)
    }
    public func RegisterOnPageLoaded(_ f:@escaping (_ page:Wikipage?)->Void) {
        _OnPageLoaded.append(f)
    }
    
    public enum WikiQueueDirection {
        case parent
        case sibling
        case child
    }
    
}
