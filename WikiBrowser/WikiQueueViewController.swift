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
        
        view.addSubview(_wikiTable!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
