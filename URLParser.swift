//
//  URLParser.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/26/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class URLParser {

    public var urlPrefix:String {
        return _urlPrefix
    }
    
    private let _urlPrefix = "https://en.m.wikipedia.org/wiki/"
    private let _mainPrefix = "https://en.m.wikipedia.org/wiki/Main_Page"
    
    public func IsAWikiArticle(url:URL)->Bool {
        let s = url.absoluteString
        
        if s.hasPrefix(_urlPrefix) && !s.hasPrefix(_mainPrefix) {
            let s_no_prefix = s.replacingOccurrences(of: _urlPrefix, with: "")
            if !s_no_prefix.contains("#") && !s_no_prefix.contains(":") {
                return true
            }
        }
        
        return false
    }
    
}
