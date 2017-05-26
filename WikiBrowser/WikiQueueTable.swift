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
        
        _wikiCollection.RegisterOnPageAdded(self.onCollectionUpdated)
        _wikiCollection.RegisterOnPageRemoved(self.onCollectionUpdated)
        _wikiCollection.RegisterOnActivePageChange(self.onCollectionUpdated)
        
        addSubview(_tableView)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _wikiCollection.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:WikiQueueCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! WikiQueueCell
        
        let wikiPage = _wikiCollection.GetPageAtOffset(indexPath.row)
        
        cell.indentationWidth = 15.0
        
        if let p = wikiPage {
            cell.indentationLevel = min(p.depth, 15)
            if p.articleName == _wikiCollection.activePage.articleName {
                cell.backgroundColor = UIColor(red: 0, green: 122.0/255, blue: 1.0, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.white
                cell.textLabel?.textColor = UIColor(red: 0, green: 122.0/255, blue: 1.0, alpha: 1.0)
            }
            if p.webView.isLoading {
                cell.textLabel?.textColor = UIColor.lightGray
                cell.textLabel?.text = "⏳\(p.articleName)"
            } else if p.unviewed {
                cell.textLabel?.text = "\(p.bookFlair)\(p.articleName)"
            } else {
                cell.textLabel?.text = "📖\(p.articleName)"
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let wikiPage = _wikiCollection.GetPageAtOffset(indexPath.row)
            
            if let p = wikiPage {
                _wikiCollection.RemovePage(wiki: p)
            }
        }
    }
    
    public func onCollectionUpdated(_ p:Wikipage?) {
        _tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let wikiPage = _wikiCollection.GetPageAtOffset(indexPath.row)
        
        print("\(wikiPage?.articleName)")
        
        if let p =  wikiPage {
            _wikiCollection.SetActivePage(page: p)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
