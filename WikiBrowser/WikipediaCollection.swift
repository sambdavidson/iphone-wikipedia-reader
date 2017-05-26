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
    private var head:[Wikipage] = []
    private var active:Wikipage?
    
    public var size: Int {
        return 0;
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
        // Perform URL request.
        // Process as child
        return
    }
    
    //Remove from set
    public func RemoveActivePage() {
        // Remove active page
        // Push any children to current level
        // Move to siblings or first child or up the tree
    }
    
    public func RemovePage(wiki:Wikipage) {
        // Find and remove the wiki.
    }
    
    //Can duplicate wiki's exist?
    
    //Must represent tree structure.
    
}
