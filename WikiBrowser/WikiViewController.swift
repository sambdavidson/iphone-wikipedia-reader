//
//  ViewController.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/19/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {
    
    private var wikiCollection:WikipediaCollection = WikipediaCollection()
    private var webView:WikiWebView?
    private var queueView: WikiQueueViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WikiWebView(frame: view.frame, collection: wikiCollection)
        
        queueView = WikiQueueViewController()
        queueView?.wikiCollection = wikiCollection
        
        navigationItem.title = "Reader"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Remove", style: .done, target: self, action: #selector(doneWithPage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(viewQueue))
        
        //navigationItem.leftBarButtonItem?.isEnabled = false; TODO add this back in.
        
        view.addSubview(webView!)
        
    }
    
    public func doneWithPage() {
        wikiCollection.RemoveActivePage()
        if wikiCollection.count > 0 {
            navigationItem.leftBarButtonItem?.isEnabled = true;
        }
        webView?.reloadActivePage()
    }
    
    public func viewQueue() {
        if let nc = navigationController {
            nc.pushViewController(queueView!, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

