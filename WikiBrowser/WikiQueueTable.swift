//
//  WikiQueueTable.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/27/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class WikiQueueTable: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var _wikiCollection:WikipediaCollection
    private var _tableView: UITableView = UITableView()
    
    init(frame fr: CGRect, wikiCollection wc:WikipediaCollection) {
        _wikiCollection = wc
        super.init(frame: fr)
        
        _tableView.frame = fr
        _tableView.delegate = self
        _tableView.dataSource = self
        
        _tableView.register(WikiQueueCell.self, forCellReuseIdentifier: "cell")
        
        addSubview(_tableView)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:WikiQueueCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! WikiQueueCell
        
        //Cell config
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Selected
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
