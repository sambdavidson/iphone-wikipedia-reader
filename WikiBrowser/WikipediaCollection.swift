//
//  WikipediaCollection.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/20/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//
import UIKit

class WikipediaCollection {
    
    private let http:HttpService
    private var root:Wikipage
    private var heads:[Wikipage] = []
    private var active:Wikipage?
    
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
        http = HttpService()
        root = Wikipage(url: URL(string: "https://en.m.wikipedia.org/wiki/Main_Page")!)
    }
    

    public func SetActivePage(page:Wikipage) {
        //TODO build tree keys
    }
    
    public func AddSubpage(url:URL) {
        
        let newPage = Wikipage(url: url)
        
        if let ap = active {
            ap.addChild(newPage)
        } else {
            heads.append(newPage)
        }
    }
    
    //Remove from set
    public func RemoveActivePage() {
        if let ap = active {
            if ap.children.count > 0 { // Move children to current level
                if let parent = ap.parent { // Add children to parent's children
                    ap.children.forEach({ parent.addChild($0)})
                } else { //Add children to heads
                    ap.children.forEach({ heads.append($0) })
                }
                active = ap.children.first
            } else { //No chilren
                if let parent = ap.parent { // Do we at least have a parent to go to
                    parent.removeChild(ap)
                    if parent.children.count > 0 { // Siblings?
                        active = parent.children.first
                    } else {
                        active = parent
                    }
                } else { // We are an orphan :'(
                    let hIdx = heads.index(where: { $0.articleName == ap.articleName })
                    if let i = hIdx {
                        _ = heads.remove(at: i)
                    }
                    
                    if heads.count > 0 { //Anything left?
                        active = heads.first
                    } else {
                        active = nil
                    }
                }
            }
            
        } else if heads.count > 0 {
            active = heads.first
        }
        print(heads.count)
    }
    
    public func RemovePage(wiki:Wikipage) {
        // Find and remove the wiki.
    }
    
    //Can duplicate wiki's exist?
    
    //Must represent tree structure.
    
}
