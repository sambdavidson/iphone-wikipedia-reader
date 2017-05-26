//
//  URLParser.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/26/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class URLParser {
    private let urlPrefix = "https://en.m.wikipedia.org/wiki/"
    private let mainPrefix = "https://en.m.wikipedia.org/wiki/Main_Page"
    
    public func IsAWikiArticle(url:URL)->Bool {
        let s = url.absoluteString
        
        if s.hasPrefix(urlPrefix) && !s.hasPrefix(mainPrefix) {
            return true
        }
        return false
    }
    
}
