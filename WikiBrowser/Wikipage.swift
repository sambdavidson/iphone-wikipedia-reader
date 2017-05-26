//
//  Wikipage.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/20/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//
import UIKit

class Wikipage {

    public var children:[Wikipage] = []
    
    public var url:URL
    
    public var html:Int {
        return 0;
    }
    
    public var webView:UIWebView //Seems like it is cool to have a zillion webViews as long as they arent all being displayed.
    
    
    //Availability? As in still downloading?
    
    init(url u:URL) {
        url = u
        webView = UIWebView()
    }
}
