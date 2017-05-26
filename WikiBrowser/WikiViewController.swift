//
//  ViewController.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/19/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {
    
    public var wikiCollection:WikipediaCollection?
    public var webView:WikiWebView?
    
    override func viewDidLoad() {
        wikiCollection = WikipediaCollection()
        webView = WikiWebView(frame: view.frame, collection: wikiCollection!)
        super.viewDidLoad()
        
        view.addSubview(webView!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

