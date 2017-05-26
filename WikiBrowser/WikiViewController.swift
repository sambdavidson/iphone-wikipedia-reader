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
        
        wikiCollection.RegisterOnPageAdded(self.onCollectionUpdated)
        wikiCollection.RegisterOnPageRemoved(self.onCollectionUpdated)
        wikiCollection.RegisterOnActivePageChange(self.onCollectionUpdated)
        
        webView = WikiWebView(frame: view.frame, collection: wikiCollection)
        
        queueView = WikiQueueViewController()
        queueView?.wikiCollection = wikiCollection
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Choose Next", style: .done, target: self, action: #selector(nextPage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Article Queue", style: .done, target: self, action: #selector(viewQueue))
        
        navigationItem.leftBarButtonItem?.isEnabled = false;
        navigationItem.rightBarButtonItem?.isEnabled = false;
        
        view.addSubview(webView!)
        
    }
    
    public func nextPage() {
        wikiCollection.NextPage()
        
        webView?.reloadActivePage()
    }
    
    public func viewQueue() {
        if let nc = navigationController {
            nc.pushViewController(queueView!, animated: true)
        }
    }
    
    public func onCollectionUpdated(_ p:Wikipage?) {
        if wikiCollection.count > 0 {
            navigationItem.leftBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            
            let nameLen:Int = 17;
            var articleName = ""
            let (oNext, oDir) = wikiCollection.GetWhatsNext()
            if let next = oNext {
                var name = next.articleName
                if name.characters.count > nameLen+3 {
                    name = name.substring(to: name.index(name.startIndex, offsetBy: nameLen)) + "..."
                }
                var dirFlair = ""
                if let dir = oDir {
                    switch(dir) {
                    case WikipediaCollection.WikiQueueDirection.child:
                        dirFlair = "↓"
                    case WikipediaCollection.WikiQueueDirection.sibling:
                        dirFlair = "→"
                    case WikipediaCollection.WikiQueueDirection.parent:
                        dirFlair = "↑"
                    }
                }
                articleName = "Next \(dirFlair) \(name)"
            } else {
                articleName = "Done"
            }
            
            navigationItem.leftBarButtonItem?.title = articleName
            navigationItem.rightBarButtonItem?.title = "\(wikiCollection.count) 📚"
            
            
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = false;
            navigationItem.rightBarButtonItem?.isEnabled = false;
            navigationItem.leftBarButtonItem?.title = "Choose Next"
            navigationItem.rightBarButtonItem?.title = "Article Queue"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

