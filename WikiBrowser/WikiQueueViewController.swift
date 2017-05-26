//
//  WikiQueueView.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/26/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class WikiQueueViewController: UIViewController {
    
    public var wikiCollection:WikipediaCollection?
    
    private var _wikiTable:WikiQueueTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _wikiTable = WikiQueueTable(frame: view.frame, wikiCollection: wikiCollection!)
    
        wikiCollection!.RegisterOnActivePageChange(self.onActivePageChange)
    
        navigationItem.title = "Article Queue"
        
        view.addSubview(_wikiTable!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        _wikiTable?.updateFrame(view.frame)
    }

    
    public func onActivePageChange(_ p:Wikipage?) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
